import 'package:async/async.dart';
import 'package:executor_sample/core/router/route.dart';
import 'package:executor_sample/data/repositories/user/exception.dart';
import 'package:executor_sample/domain/models/user.dart';
import 'package:executor_sample/presentation/shared/dialog/app_dialog.dart';
import 'package:executor_sample/presentation/shared/list_tile/app_list_tile.dart';
import 'package:executor_sample/presentation/shared/list_tile/throw_exception_switch_list_tile.dart';
import 'package:executor_sample/presentation/shared/snack_bar/app_snack_bar.dart';
import 'package:executor_sample/presentation/shared/state/throw_exception.dart';
import 'package:executor_sample/use_case/executors/repositories/user/create_user/executor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'action_controllers/_create_user.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createUserController = _useCreateUserController(ref);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            spacing: 12,
            children: [
              const ThrowExceptionSwitchListTile(),
              AppListTile(
                screenName: 'Home Detail screen',
                onTap: () => const HomeDetailRoute().go(context),
              ),
              const Divider(),
              ElevatedButton(
                onPressed: () async =>
                    _createUserButtonTap(context, createUserController),
                child: const Text('create user'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on HomeScreen {
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
