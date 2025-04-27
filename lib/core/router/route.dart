import 'package:executor_sample/core/router/app_navigation_bar.dart';
import 'package:executor_sample/presentation/screens/home/screen.dart';
import 'package:executor_sample/presentation/screens/home_detail/screen.dart';
import 'package:executor_sample/presentation/screens/todo/screen.dart';
import 'package:executor_sample/presentation/screens/todo_detail/screen.dart';
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
              path: HomeRoute.path,
              name: HomeRoute.name,
              routes: [
                TypedGoRoute<HomeDetailRoute>(
                  path: HomeDetailRoute.path,
                  name: HomeDetailRoute.name,
                ),
              ],
            ),
          ],
        ),
        TypedStatefulShellBranch<TodoBranch>(
          routes: [
            TypedGoRoute<TodoRoute>(
              path: TodoRoute.path,
              name: TodoRoute.name,
              routes: [
                TypedGoRoute<TodoDetailRoute>(
                  path: TodoDetailRoute.path,
                  name: TodoDetailRoute.name,
                ),
              ],
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

  static const path = '/';
  static const name = 'home_screen';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

class HomeDetailRoute extends GoRouteData {
  const HomeDetailRoute();

  static const path = 'home_detail_screen';
  static const name = 'home_detail_screen';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeDetailScreen();
  }
}

class TodoRoute extends GoRouteData {
  const TodoRoute();

  static const path = '/todo_screen';
  static const name = 'todo_screen';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TodoScreen();
  }
}

class TodoDetailRoute extends GoRouteData {
  const TodoDetailRoute();

  static const path = 'todo_detail_screen';
  static const name = 'todo_detail_screen';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TodoDetailScreen();
  }
}
