part of '../app_modal.dart';

typedef _ModalController = ({
  Future<bool> Function(User user) createUser,
  Future<bool> Function() updateUser,
  Future<bool> Function(String todoId) scheduleTodoNotification,
});

/// モーダルのアクションとエラーハンドラを提供するためのフック
///
/// 複数のアクションが必要な場合は、ここのアクションをまとめるフックを用意する
_ModalController _useModalController(WidgetRef ref) {
  final createUserController = _useCreateUserController(ref);
  final updateUserController = _updateUserController(ref);
  final scheduleTodoNotificationController =
      _useScheduleTodoNotificationController(ref);

  return (
    createUser: createUserController.action,
    updateUser: updateUserController.action,
    scheduleTodoNotification: scheduleTodoNotificationController.action,
  );
}
