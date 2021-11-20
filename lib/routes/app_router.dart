import 'package:android_midterm/screens/authentication/sign_in_screen.dart';
import 'package:android_midterm/screens/authentication/sign_up_screen.dart';
import 'package:android_midterm/screens/dashboard_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auto_route/annotations.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Screen', routes: <AutoRoute>[
  CustomRoute(
      path: '/signin',
      page: SignInScreen,
      initial: true,
      transitionsBuilder: TransitionsBuilders.slideRightWithFade),
  AutoRoute(
    path: '/signup',
    page: SignUpScreen,
  ),
  AutoRoute(
    path: '/dashboard',
    page: DashboardScreen,
  ),
])
class $AppRouter {}
