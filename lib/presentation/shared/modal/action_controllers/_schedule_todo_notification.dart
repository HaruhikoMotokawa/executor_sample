part of '../app_modal.dart';

typedef _ScheduleTodoNotificationController = ({
  Future<bool> Function(String todoId) action,
});

/// ScheduleTodoNotificationActionを使用するためのフック
_ScheduleTodoNotificationController _useScheduleTodoNotificationController(
  WidgetRef ref,
) {
  //----------------------------------------------------------------------------
  // property
  //----------------------------------------------------------------------------
  final provider = scheduleTodoNotificationExecutorProvider;
  final scheduleTodoNotification = ref.read(provider.notifier);
  final cache = AsyncCache<bool>.ephemeral();

  //----------------------------------------------------------------------------
  // action
  //----------------------------------------------------------------------------
  Future<bool> action(String todoId) async {
    return cache.fetch(() async {
      // INFO: 例外をスローするかどうかを渡す
      await scheduleTodoNotification(todoId: todoId);

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
    onException: (exception, context) {
      switch (exception) {
        default:
          showAppDialog(
            context,
            title: '不明なエラー',
            message: '予期しないエラーが発生しました。',
            buttonText: '閉じる',
            colorType: ColorType.modal,
          );
      }
    },
  );

  //----------------------------------------------------------------------------
  // return
  //----------------------------------------------------------------------------
  return (action: action);
}
