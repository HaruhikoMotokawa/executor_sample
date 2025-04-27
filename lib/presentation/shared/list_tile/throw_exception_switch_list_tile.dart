import 'package:executor_sample/presentation/shared/state/throw_exception.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThrowExceptionSwitchListTile extends ConsumerWidget {
  const ThrowExceptionSwitchListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final throwExceptionState = ref.watch(throwExceptionProvider);
    final switchThrowException = ref.watch(throwExceptionProvider.notifier);
    return Container(
      decoration: BoxDecoration(
        color: Colors.red[100],
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SwitchListTile(
        title: const Text('Throw Exception'),
        value: throwExceptionState,
        onChanged: (value) => switchThrowException(),
      ),
    );
  }
}
