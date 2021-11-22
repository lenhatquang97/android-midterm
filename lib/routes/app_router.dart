import 'package:android_midterm/screens/add_debt.dart';
import 'package:android_midterm/screens/add_order.dart';
import 'package:android_midterm/screens/authentication/sign_in_screen.dart';
import 'package:android_midterm/screens/authentication/sign_up_screen.dart';
import 'package:android_midterm/screens/billing_log_screen.dart';
import 'package:android_midterm/screens/dashboard_screen.dart';
import 'package:android_midterm/screens/debt_log_screen.dart';
import 'package:android_midterm/screens/debt_screen.dart';
import 'package:android_midterm/screens/order_screen.dart';
import 'package:android_midterm/screens/wrapper/authentication_wrapper_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auto_route/annotations.dart';
//Uncomment to prepare for generating
//part 'app_router.g.dart';
//Command for generating the router file
//flutter pub run build_runner build --delete-conflicting-outputs

@MaterialAutoRouter(replaceInRouteName: 'Page,Screen', routes: <AutoRoute>[
  CustomRoute(
      path: '/wrapper',
      page: AuthenticationWrapperScreen,
      initial: true,
      transitionsBuilder: TransitionsBuilders.slideRightWithFade),
  CustomRoute(
    path: '/signin',
    page: SignInScreen,
  ),
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
  AutoRoute(path: '/debt-log', page: DebtLogScreen),
  AutoRoute(path: '/order-log', page: BillingLogScreen),
  AutoRoute(path: '/add-debt', page: AddDebt),
  AutoRoute(path: '/add-order', page: AddOrder)
])
class $AppRouter {}
