import 'package:flutter/material.dart';
import 'package:ipacking_app/src/feature/home/presentation/screens/home_screen.dart';
import 'package:ipacking_app/src/feature/scan_qr/presentation/screens/read_with_qr_screen.dart';
import 'package:ipacking_app/src/feature/scan_qr/presentation/screens/scan_qr_screen.dart';
import 'package:ipacking_app/src/shared/config/routes/route_names.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../injection_container.dart';
import '../../../feature/login/presentation/screens/login_screen.dart';
import '../../../feature/splash/presentation/screens/splash_screen.dart';
import '../../blocs_app/loading_cubit/loading_cubit.dart';
import '../../utils/log_utils.dart';
import '../../widgets/pop_scope_scaffold.dart';

class Routes {
  final LoadingCubit loadingCubit;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  factory Routes() => _instance;

  Routes._internal(this.loadingCubit);

  static final Routes _instance = Routes._internal(getIt<LoadingCubit>());

  static Routes get instance => _instance;

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) async {
    return navigatorKey.currentState
        ?.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateAndRemove(String routeName,
      {String? routeStopName, dynamic arguments}) async {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      routeStopName == null
          ? (Route<dynamic> route) => false
          : ModalRoute.withName(routeStopName),
      arguments: arguments,
    );
  }

  Future<dynamic> navigateAndReplace(String routeName,
      {dynamic arguments}) async {
    return navigatorKey.currentState
        ?.pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateAndReplaceName(String routeName,
      {dynamic arguments}) async {
    return navigatorKey.currentState
        ?.pushReplacementNamed(routeName, arguments: arguments);
  }

  dynamic pop({dynamic result}) {
    loadingCubit.hideLoading();
    return navigatorKey.currentState?.pop(result);
  }

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    LOG.info('Route name: ${settings.name}');
    try {
      switch (settings.name) {
        // case "/":
        //   return _pageRoute(page: const SplashScreen(), setting: settings);
        case RouteNames.splashScreen:
          return _pageRoute(page: const SplashScreen(), setting: settings);
        case RouteNames.loginScreen:
          return _pageRoute(page: const LoginScreen(), setting: settings);
        case RouteNames.homeScreen:
          return _pageRoute(page: const HomeScreen(), setting: settings);
        case RouteNames.scanQRScreen:
          final arg = settings.arguments as Map<String, dynamic>;
          return _pageRoute(
              page: ScanQRScreen(
                systemConfig: arg["systemConfig"],
                laneId: arg["laneId"],
              ),
              setting: settings);
        case RouteNames.readWithQRScreen:
          final arg = settings.arguments as Map<String, dynamic>;
          return _pageRoute(
              page: ReadWithQRScreen(
                scanCode: arg["scanCode"],
                systemConfig: arg["systemConfig"],
                laneId: arg["laneId"],
              ),
              setting: settings);
        // default:
        //   return _pageRoute(page: const SplashScreen(), setting: settings);
      }
    } catch (e) {
      LOG.error(e);
    }
  }

  static PageTransition _pageRoute({
    PageTransitionType? transition,
    RouteSettings? setting,
    required Widget page,
  }) =>
      PageTransition(
        child: page,
        type: transition ?? PageTransitionType.rightToLeft,
        settings:
            RouteSettings(arguments: setting?.arguments, name: setting?.name),
      );

  static MaterialPageRoute _emptyRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => PopScopeScaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: InkWell(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            onTap: () => Navigator.of(context).pop(),
            child: const Center(
              child: Text(
                'Back',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        body: Center(
          child: Text('No path for ${settings.name}'),
        ),
      ),
    );
  }
}
