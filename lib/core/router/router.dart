import 'package:executor_sample/core/router/route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) => _goRouter;

final _goRouter = GoRouter(
  navigatorKey: rootNavigationKey,
  // アプリが起動した時
  initialLocation: const HomeRoute().location,
  // パスと画面の組み合わせ
  routes: $appRoutes,
  // 遷移ページがないなどのエラーが発生した時に、このページに行く
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
  ),
);
