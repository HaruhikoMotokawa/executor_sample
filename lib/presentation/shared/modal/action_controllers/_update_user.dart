part of '../app_modal.dart';

typedef _UpdateUserController = ({
  Future<bool> Function() action,
});

_UpdateUserController _updateUserController(WidgetRef ref) {
  //----------------------------------------------------------------------------
  // property
  //----------------------------------------------------------------------------
  final provider = updateUserExecutorProvider;
  final updateUser = ref.read(provider.notifier);
  final cache = AsyncCache<bool>.ephemeral();

  // INFO: テストのために例外をスローするかどうかをwatch
  final throwException = ref.watch(throwExceptionProvider);

  //----------------------------------------------------------------------------
  // action
  //----------------------------------------------------------------------------
  Future<bool> action() async {
    return cache.fetch(() async {
      // INFO: 例外をスローするかどうかを渡す
      await updateUser(throwException: throwException);

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
        case UserNotFoundException():
          showAppDialog(
            context,
            title: 'ユーザーが見つかりません',
            message: '指定されたユーザーが見つかりませんでした。',
            buttonText: '閉じる',
            colorType: ColorType.modal,
          );

        case ServerErrorException():
          showAppDialog(
            context,
            title: 'サーバーエラー',
            message: 'サーバーでエラーが発生しました。時間をおいて再試行してください。',
            buttonText: '閉じる',
            colorType: ColorType.modal,
          );

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
