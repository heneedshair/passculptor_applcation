import 'package:auto_route/auto_route.dart';
import 'package:code_generator_app/common/objects/code_generator/code_generator_types.dart';
import 'package:code_generator_app/ui/features/main/main_screen.dart';
import 'package:code_generator_app/ui/features/settings/settings_screen.dart';
import 'package:flutter/rendering.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  // @override
  // RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MainRoute.page, initial: true),
        AutoRoute(page: SettingsRoute.page),
      ];
}
