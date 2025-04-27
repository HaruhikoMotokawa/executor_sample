import 'package:executor_sample/presentation/shared/modal/app_modal.dart';
import 'package:flutter/material.dart';

class HomeDetailScreen extends StatelessWidget {
  const HomeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Detail Screen'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              AppModal.show(context);
            },
            child: const Text('app modal'),
          ),
        ],
      ),
    );
  }
}
