import 'package:flutter/material.dart';

class AppModal extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          Text('App Modal', style: Theme.of(context).textTheme.titleLarge),
          const ListTile(
            title: Text('Title'),
          ),
        ],
      ),
    );
  }
}
