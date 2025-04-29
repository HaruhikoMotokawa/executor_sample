part of '../screen.dart';

typedef _CreateUserController = ({
  Future<bool> Function(User user) action,
});

/// CreateUserActionを使用するためのフック
_CreateUserController _useCreateUserController(WidgetRef ref) {
  final controller = useCreateUserController(
    ref,
    TodoRoute.path,
    onDuplicateUserNameException: (context) {
      showAppBanner(
        context,
        message: '同じ名前のユーザーがすでに存在します。',
      );
    },
    onServerErrorException: (context) {
      showAppBanner(
        context,
        message: 'サーバーエラーが発生しました。時間をおいて再試行してください。',
      );
    },
    onDefaultHandler: (context) {
      showAppBanner(
        context,
        message: '予期しないエラーが発生しました。時間をおいて再試行してください。',
      );
    },
  );

  return (action: controller.action);
}
