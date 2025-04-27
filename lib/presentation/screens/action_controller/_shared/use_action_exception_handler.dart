import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ActionControllerで発生したExceptionをハンドリングするためのカスタムフック
void useActionExceptionHandler<T>(
  Refreshable<AsyncValue<T>> provider,
  WidgetRef ref, {
  required void Function(
    Exception exception,
    BuildContext context,
  ) onException,
}) {
  final context = useContext();

  ref.listen<AsyncValue<T>>(
    provider,
    (_, next) {
      if (next.hasError == false && next.isLoading) return;

      if (next.error case final exception? when exception is Exception) {
        onException(exception, context);
      }
    },
  );
}
