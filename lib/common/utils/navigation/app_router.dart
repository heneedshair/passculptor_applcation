import 'package:auto_route/auto_route.dart';
import 'package:code_generator_app/ui/main/main_screen.dart';
import 'package:code_generator_app/ui/settings/settings_screen.dart';

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
