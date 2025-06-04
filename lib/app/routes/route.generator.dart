import 'package:flutter/material.dart';
import 'package:zoozitest/features/authentication/presentation/pages/login.page.dart';
import 'package:zoozitest/features/authentication/presentation/pages/register.page.dart';
import 'package:zoozitest/shared/widgets/splashscreen_page.dart';
import 'app.routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}