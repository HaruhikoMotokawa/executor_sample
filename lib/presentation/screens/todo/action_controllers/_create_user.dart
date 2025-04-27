part of '../screen.dart';

typedef _CreateUserController = ({
  Future<bool> Function(User user) action,
});

/// CreateUserActionを使用するためのフック
_CreateUserController _useCreateUserController(WidgetRef ref) {
  //----------------------------------------------------------------------------
  // property
  //----------------------------------------------------------------------------
  final provider = createUserExecutorProvider;
  final createUser = ref.read(provider.notifier);
  final context = useContext();
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
  ref.listen(provider, (_, next) {
    if (next.hasError == false && next.isLoading) return;

    final isCurrent = GoRouter.of(context).isCurrentLocation(TodoRoute.path);
    if (!isCurrent) return;

    if (next.error case final exception? when exception is Exception) {
      switch (exception) {
        case DuplicateUserNameException():
          showAppBanner(
            context,
            message: '同じ名前のユーザーがすでに存在します。',
          );

        case ServerErrorException():
          showAppBanner(
            context,
            message: 'サーバーエラーが発生しました。時間をおいて再試行してください。',
          );

        default:
          showAppBanner(
            context,
            message: '予期しないエラーが発生しました。時間をおいて再試行してください。',
          );
      }
    }
  });

  //----------------------------------------------------------------------------
  // return
  //----------------------------------------------------------------------------
  return (action: action);
}
