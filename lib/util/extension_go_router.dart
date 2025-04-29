import 'package:go_router/go_router.dart';

extension GoRouterExtension on GoRouter {
  /// 引数の[routePath]が現在のルートのパスと一致するかどうかを判定する。
  bool isCurrentLocation(String routePath) {
    final lastMatch = routerDelegate.currentConfiguration.last;
    final matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    final location = matchList.uri.toString();
    return location.endsWith(routePath);
  }
}
