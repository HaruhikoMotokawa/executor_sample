part of 'app_modal.dart';

typedef _ModalController = ({
  Future<bool> Function(User user) createUser,
});

_ModalController _useModalController(WidgetRef ref) {
  final createUserController = _useCreateUserController(ref);

  return (createUser: createUserController.action);
}
