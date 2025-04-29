import 'package:executor_sample/presentation/shared/modal/app_modal.dart';
import 'package:flutter/material.dart';

class TodoDetailScreen extends StatelessWidget {
  const TodoDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Detail Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            ElevatedButton(
              onPressed: () {
                AppModal.show(context);
              },
              child: const Text('app modal'),
            ),
          ],
        ),
      ),
    );
  }
}
