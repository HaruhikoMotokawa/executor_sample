import 'package:async/async.dart';
import 'package:executor_sample/data/repositories/user/exception.dart';
import 'package:executor_sample/domain/models/user.dart';
import 'package:executor_sample/presentation/screens/action_controller/_shared/use_action_exception_handler.dart';
import 'package:executor_sample/presentation/shared/state/throw_exception.dart';
import 'package:executor_sample/use_case/executors/repositories/user/create_user/executor.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef CreateUserController = ({
  Future<bool> Function(User user) action,
});

CreateUserController useCreateUserController(
  WidgetRef ref, {
  required void Function(BuildContext context) onDuplicateUserNameException,
  required void Function(BuildContext context) onServerErrorException,
  required void Function(BuildContext context) onDefaultHandler,
  String? callerPath,
}) {
  //----------------------------------------------------------------------------
  // property
  //----------------------------------------------------------------------------
  final provider = createUserExecutorProvider;
  final createUser = ref.read(provider.notifier);
  final cache = AsyncCache<bool>.ephemeral();

  // INFO: テストのために例外をスローするかどうかをwatch
  final throwException = ref.watch(throwExceptionProvider);

  //----------------------------------------------------------------------------
  // action
  //----------------------------------------------------------------------------
  Future<bool> action(User user) async {
    return cache.fetch(() async {
      // INFO: 例外をスローするかどうかを渡す
      await createUser(user, throwException: throwException);

      final hasError = ref.read(provider).hasError;
      if (hasError) return false;

      return true;
    });
  }

  //----------------------------------------------------------------------------
  // Exception Handler
  //----------------------------------------------------------------------------
  useActionExceptionHandler(
    provider,
    ref,
    callerPath: callerPath,
    onException: (exception, context) {
      switch (exception) {
        case DuplicateUserNameException():
          onDuplicateUserNameException(context);

        case ServerErrorException():
          onServerErrorException(context);

        default:
          onDefaultHandler(context);
      }
    },
  );
  //----------------------------------------------------------------------------
  // return
  //----------------------------------------------------------------------------
  return (action: action);
}
