import 'package:executor_sample/util/extension_go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ActionControllerで発生したExceptionをハンドリングするためのカスタムフック
void useActionExceptionHandler<T>(
  Refreshable<AsyncValue<T>> provider,
  WidgetRef ref, {
  required void Function(
    Exception exception,
    BuildContext context,
  ) onException,
  String? callerPath,
}) {
  final context = useContext();

  ref.listen<AsyncValue<T>>(
    provider,
    (_, next) {
      if (next.hasError == false && next.isLoading) return;

      if (callerPath != null) {
        final isCurrent = GoRouter.of(context).isCurrentLocation(callerPath);
        if (!isCurrent) return;
      }

      if (next.error case final exception? when exception is Exception) {
        onException(exception, context);
      }
    },
  );
}
