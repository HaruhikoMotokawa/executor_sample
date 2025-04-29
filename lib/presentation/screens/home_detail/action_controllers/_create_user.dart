part of '../screen.dart';

typedef _CreateUserController = ({
  Future<bool> Function(User user) action,
});

/// CreateUserActionを使用するためのフック
_CreateUserController _useCreateUserController(WidgetRef ref) {
  final controller = useCreateUserController(
    ref,
    callerPath: HomeDetailRoute.path,
    onDuplicateUserNameException: (context) {
      showAppDialog(
        context,
        title: 'ユーザー名の重複',
        message: 'このユーザー名はすでに使用されています。',
        buttonText: '閉じる',
        colorType: ColorType.homeDetail,
      );
    },
    onServerErrorException: (context) {
      showAppDialog(
        context,
        title: 'サーバーエラー',
        message: 'サーバーでエラーが発生しました。時間をおいて再試行してください。',
        buttonText: '閉じる',
        colorType: ColorType.homeDetail,
      );
    },
    onDefaultHandler: (context) {
      showAppDialog(
        context,
        title: '不明なエラー',
        message: '予期しないエラーが発生しました。',
        buttonText: '閉じる',
        colorType: ColorType.homeDetail,
      );
    },
  );

  return (action: controller.action);
}
