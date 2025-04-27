import 'package:executor_sample/core/router/app_navigation_bar.dart';
import 'package:executor_sample/presentation/screens/home/screen.dart';
import 'package:executor_sample/presentation/screens/todo/screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'route.g.dart';

/// アプリケーション全体のナビゲーションを管理するためのキー。
/// このキーを使うことで、アプリケーションのどこからでも
/// ナビゲーターに直接アクセスし、画面遷移を制御することができる。
final rootNavigationKey = GlobalKey<NavigatorState>();

// 大元のルート
@TypedShellRoute<AppShellRoute>(
  routes: [
    TypedStatefulShellRoute<NavigationShellRoute>(
      branches: [
        TypedStatefulShellBranch<HomeBranch>(
          routes: [
            TypedGoRoute<HomeRoute>(
              path: '/',
              name: 'home_screen',
            ),
          ],
        ),
        TypedStatefulShellBranch<TodoBranch>(
          routes: [
            TypedGoRoute<TodoRoute>(
              path: '/todo_screen',
              name: 'todo_screen',
            ),
          ],
        ),
      ],
    ),
  ],
)

/// アプリの大元のルート
class AppShellRoute extends ShellRouteData {
  const AppShellRoute();

  static final $navigationKey = rootNavigationKey;

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    Widget navigator,
  ) {
    return Scaffold(
      body: navigator,
    );
  }
}

// Branchはタブのルートの入れ物

class HomeBranch extends StatefulShellBranchData {
  const HomeBranch();
}

class TodoBranch extends StatefulShellBranchData {
  const TodoBranch();
}

/// タブのナビゲーターを設定
class NavigationShellRoute extends StatefulShellRouteData {
  const NavigationShellRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppNavigationBar(
        navigationShell: navigationShell,
      ),
    );
  }
}

// それぞれの画面を設定

class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

class TodoRoute extends GoRouteData {
  const TodoRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TodoScreen();
  }
}
