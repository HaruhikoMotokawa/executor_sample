import 'package:executor_sample/data/repositories/user/provider.dart';
import 'package:executor_sample/domain/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'executor.g.dart';

@riverpod
class CreateUserExecutor extends _$CreateUserExecutor {
  @override
  FutureOr<void> build() {}

  FutureOr<void> call(User user, {required bool throwException}) async {
    state = await AsyncValue.guard(() async {
      await ref
          .read(userRepositoryProvider)
          .create(user, throwException: throwException);
    });
  }
}
