import 'package:async/async.dart';
import 'package:executor_sample/data/repositories/user/exception.dart';
import 'package:executor_sample/domain/models/user.dart';
import 'package:executor_sample/presentation/shared/action_controller/_shared/use_action_exception_handler.dart';
import 'package:executor_sample/presentation/shared/action_controller/create_user/controller.dart';
import 'package:executor_sample/presentation/shared/dialog/app_dialog.dart';
import 'package:executor_sample/presentation/shared/snack_bar/app_snack_bar.dart';
import 'package:executor_sample/presentation/shared/state/throw_exception.dart';
import 'package:executor_sample/use_case/executors/repositories/user/update_user/executor.dart';
import 'package:executor_sample/use_case/executors/services/notification/schedule_todo_notification/executor.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part '_list_tile.dart';
part '_modal_controller.dart';
part 'action_controllers/_create_user.dart';
part 'action_controllers/_schedule_todo_notification.dart';
part 'action_controllers/_update_user.dart';

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
          _ListTile(
            title: 'Create User',
            onTap: () => _createUserListTileTap(context, controller),
          ),
          _ListTile(
            title: 'Update User',
            onTap: () => _updateUserListTileTap(context, controller),
          ),
          _ListTile(
            title: 'Schedule Todo Notification',
            onTap: () =>
                _scheduleTodoNotificationListTileTap(context, controller),
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

  Future<void> _updateUserListTileTap(
    BuildContext context,
    _ModalController controller,
  ) async {
    final success = await controller.updateUser();
    if (success && context.mounted) {
      Navigator.of(context).pop();
      await showAppSnackBar(context, message: 'User updated successfully.');
    }
  }

  Future<void> _scheduleTodoNotificationListTileTap(
    BuildContext context,
    _ModalController controller,
  ) async {
    final success = await controller.scheduleTodoNotification('todo_id_1');
    if (success && context.mounted) {
      Navigator.of(context).pop();
      await showAppSnackBar(
        context,
        message: 'Todo notification scheduled successfully.',
      );
    }
  }
}
