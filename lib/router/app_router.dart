import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: LandingRoute.page,
      initial: true,
      path: "/",
      children: [
        AutoRoute(page: HomeRoute.page, initial: true, path: "home"),
        AutoRoute(page: SearchRoute.page, path: "search"),
      ],
    ),
  ];
}
