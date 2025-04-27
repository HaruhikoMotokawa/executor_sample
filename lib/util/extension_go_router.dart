import 'package:go_router/go_router.dart';

extension GoRouterExtension on GoRouter {
  bool isCurrentLocation(String routePath) {
    final lastMatch = routerDelegate.currentConfiguration.last;
    final matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    final location = matchList.uri.toString();
    return location.endsWith(routePath);
  }
}
