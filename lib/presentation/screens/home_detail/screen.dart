import 'package:executor_sample/core/router/route.dart';
import 'package:executor_sample/domain/models/user.dart';
import 'package:executor_sample/presentation/shared/action_controller/create_user/controller.dart';
import 'package:executor_sample/presentation/shared/dialog/app_dialog.dart';
import 'package:executor_sample/presentation/shared/snack_bar/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'action_controllers/_create_user.dart';

class HomeDetailScreen extends HookConsumerWidget {
  const HomeDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createUserController = _useCreateUserController(ref);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Detail Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            ElevatedButton(
              onPressed: () async =>
                  _createUserButtonTap(context, createUserController),
              child: const Text('create user'),
            ),
          ],
        ),
      ),
    );
  }
}

extension on HomeDetailScreen {
  Future<void> _createUserButtonTap(
    BuildContext context,
    _CreateUserController controller,
  ) async {
    final user = User(
      id: '1',
      name: 'test',
      email: 'test@example.com',
    );

    final result = await controller.action(user);
    if (!result || !context.mounted) return;

    await showAppSnackBar(context, message: 'User created successfully.');
  }
}
