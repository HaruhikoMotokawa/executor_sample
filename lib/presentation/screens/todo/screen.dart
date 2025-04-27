import 'package:executor_sample/core/router/route.dart';
import 'package:flutter/material.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Screen'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            spacing: 12,
            children: [
              ElevatedButton(
                onPressed: () => const TodoDetailRoute().go(context),
                child: const Text('Go to Todo Detail Screen'),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
