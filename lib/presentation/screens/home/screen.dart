import 'package:executor_sample/core/router/route.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => const HomeDetailRoute().go(context),
          child: const Text('Go to Home Detail Screen'),
        ),
      ),
    );
  }
}
