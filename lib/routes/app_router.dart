import 'package:android_midterm/screens/authentication/sign_in_screen.dart';
import 'package:android_midterm/screens/authentication/sign_up_screen.dart';
import 'package:android_midterm/screens/dashboard_screen.dart';
import 'package:android_midterm/screens/debt_screen.dart';
import 'package:android_midterm/screens/order_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auto_route/annotations.dart';
// part 'app_router.g.dart';

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
  AutoRoute(
    path: '/debt-detail',
    page: DebtScreen,
  ),
  AutoRoute(
    path: '/order-detail',
    page: OrderScreen,
  ),
])
class $AppRouter {}
