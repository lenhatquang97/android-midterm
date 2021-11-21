// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../screens/authentication/sign_in_screen.dart' as _i1;
import '../screens/authentication/sign_up_screen.dart' as _i2;
import '../screens/dashboard_screen.dart' as _i3;
import '../screens/debt_screen.dart' as _i4;
import '../screens/order_screen.dart' as _i5;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    SignInScreen.name: (routeData) {
      return _i6.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i1.SignInScreen(),
          transitionsBuilder: _i6.TransitionsBuilders.slideRightWithFade,
          opaque: true,
          barrierDismissible: false);
    },
    SignUpScreen.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.SignUpScreen());
    },
    DashboardScreen.name: (routeData) {
      final args = routeData.argsAs<DashboardScreenArgs>(
          orElse: () => const DashboardScreenArgs());
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.DashboardScreen(key: args.key));
    },
    DebtScreen.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.DebtScreen());
    },
    OrderScreen.name: (routeData) {
      final args = routeData.argsAs<OrderScreenArgs>(
          orElse: () => const OrderScreenArgs());
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: _i5.OrderScreen(key: args.key));
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig('/#redirect',
            path: '/', redirectTo: '/signin', fullMatch: true),
        _i6.RouteConfig(SignInScreen.name, path: '/signin'),
        _i6.RouteConfig(SignUpScreen.name, path: '/signup'),
        _i6.RouteConfig(DashboardScreen.name, path: '/dashboard'),
        _i6.RouteConfig(DebtScreen.name, path: '/debt-detail'),
        _i6.RouteConfig(OrderScreen.name, path: '/order-detail')
      ];
}

/// generated route for [_i1.SignInScreen]
class SignInScreen extends _i6.PageRouteInfo<void> {
  const SignInScreen() : super(name, path: '/signin');

  static const String name = 'SignInScreen';
}

/// generated route for [_i2.SignUpScreen]
class SignUpScreen extends _i6.PageRouteInfo<void> {
  const SignUpScreen() : super(name, path: '/signup');

  static const String name = 'SignUpScreen';
}

/// generated route for [_i3.DashboardScreen]
class DashboardScreen extends _i6.PageRouteInfo<DashboardScreenArgs> {
  DashboardScreen({_i7.Key? key})
      : super(name, path: '/dashboard', args: DashboardScreenArgs(key: key));

  static const String name = 'DashboardScreen';
}

class DashboardScreenArgs {
  const DashboardScreenArgs({this.key});

  final _i7.Key? key;

  @override
  String toString() {
    return 'DashboardScreenArgs{key: $key}';
  }
}

/// generated route for [_i4.DebtScreen]
class DebtScreen extends _i6.PageRouteInfo<void> {
  const DebtScreen() : super(name, path: '/debt-detail');

  static const String name = 'DebtScreen';
}

/// generated route for [_i5.OrderScreen]
class OrderScreen extends _i6.PageRouteInfo<OrderScreenArgs> {
  OrderScreen({_i7.Key? key})
      : super(name, path: '/order-detail', args: OrderScreenArgs(key: key));

  static const String name = 'OrderScreen';
}

class OrderScreenArgs {
  const OrderScreenArgs({this.key});

  final _i7.Key? key;

  @override
  String toString() {
    return 'OrderScreenArgs{key: $key}';
  }
}
