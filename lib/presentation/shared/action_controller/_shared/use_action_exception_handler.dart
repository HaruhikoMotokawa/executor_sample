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
      // エラーが発生していない場合は何もしない
      if (next.hasError == false && next.isLoading) return;

      // pathが指定されている場合は判定する
      if (callerPath != null) {
        // 指定されたpathと現在のpathが一致しない場合は何もしない
        final isCurrent = GoRouter.of(context).isCurrentLocation(callerPath);
        if (!isCurrent) return;
      }

      // エラーが発生している場合はonExceptionを呼び出す
      if (next.error case final exception? when exception is Exception) {
        onException(exception, context);
      }
    },
  );
}
