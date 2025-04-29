part of 'app_modal.dart';

typedef _ModalController = ({
  Future<bool> Function(User user) createUser,
  Future<bool> Function() updateUser,
  Future<bool> Function(String todoId) scheduleTodoNotification,
});

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
