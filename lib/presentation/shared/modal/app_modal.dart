import 'package:executor_sample/domain/models/user.dart';
import 'package:executor_sample/presentation/screens/action_controller/create_user/controller.dart';
import 'package:executor_sample/presentation/shared/dialog/app_dialog.dart';
import 'package:executor_sample/presentation/shared/snack_bar/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part '_modal_controller.dart';
part 'action_controllers/_create_user.dart';

class AppModal extends HookConsumerWidget {
  const AppModal({super.key});

  static Future<void> show(BuildContext context) async {
    return showModalBottomSheet(
      showDragHandle: true,
      useRootNavigator: true,
      context: context,
      builder: (context) => const AppModal(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = _useModalController(ref);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          Text('App Modal', style: Theme.of(context).textTheme.titleLarge),
          ListTile(
            title: const Text('create user'),
            onTap: () => _createUserListTileTap(context, controller),
          ),
        ],
      ),
    );
  }
}

extension on AppModal {
  Future<void> _createUserListTileTap(
    BuildContext context,
    _ModalController controller,
  ) async {
    final user = User(
      id: '1',
      name: 'test',
      email: 'test@example.com',
    );
    final success = await controller.createUser(user);
    if (success && context.mounted) {
      Navigator.of(context).pop();
      await showAppSnackBar(context, message: 'User created successfully.');
    }
  }
}
