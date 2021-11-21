// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../screens/authentication/sign_in_screen.dart' as _i2;
import '../screens/authentication/sign_up_screen.dart' as _i3;
import '../screens/dashboard_screen.dart' as _i4;
import '../screens/debt_screen.dart' as _i5;
import '../screens/order_screen.dart' as _i6;
import '../screens/wrapper/authentication_wrapper_screen.dart' as _i1;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    AuthenticationWrapperScreen.name: (routeData) {
      return _i7.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i1.AuthenticationWrapperScreen(),
          transitionsBuilder: _i7.TransitionsBuilders.slideRightWithFade,
          opaque: true,
          barrierDismissible: false);
    },
    SignInScreen.name: (routeData) {
      return _i7.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i2.SignInScreen(),
          opaque: true,
          barrierDismissible: false);
    },
    SignUpScreen.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.SignUpScreen());
    },
    DashboardScreen.name: (routeData) {
      final args = routeData.argsAs<DashboardScreenArgs>(
          orElse: () => const DashboardScreenArgs());
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.DashboardScreen(key: args.key));
    },
    DebtScreen.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.DebtScreen());
    },
    OrderScreen.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.OrderScreen());
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig('/#redirect',
            path: '/', redirectTo: '/wrapper', fullMatch: true),
        _i7.RouteConfig(AuthenticationWrapperScreen.name, path: '/wrapper'),
        _i7.RouteConfig(SignInScreen.name, path: '/signin'),
        _i7.RouteConfig(SignUpScreen.name, path: '/signup'),
        _i7.RouteConfig(DashboardScreen.name, path: '/dashboard'),
        _i7.RouteConfig(DebtScreen.name, path: '/debt-detail'),
        _i7.RouteConfig(OrderScreen.name, path: '/order-detail')
      ];
}

/// generated route for [_i1.AuthenticationWrapperScreen]
class AuthenticationWrapperScreen extends _i7.PageRouteInfo<void> {
  const AuthenticationWrapperScreen() : super(name, path: '/wrapper');

  static const String name = 'AuthenticationWrapperScreen';
}

/// generated route for [_i2.SignInScreen]
class SignInScreen extends _i7.PageRouteInfo<void> {
  const SignInScreen() : super(name, path: '/signin');

  static const String name = 'SignInScreen';
}

/// generated route for [_i3.SignUpScreen]
class SignUpScreen extends _i7.PageRouteInfo<void> {
  const SignUpScreen() : super(name, path: '/signup');

  static const String name = 'SignUpScreen';
}

/// generated route for [_i4.DashboardScreen]
class DashboardScreen extends _i7.PageRouteInfo<DashboardScreenArgs> {
  DashboardScreen({_i8.Key? key})
      : super(name, path: '/dashboard', args: DashboardScreenArgs(key: key));

  static const String name = 'DashboardScreen';
}

class DashboardScreenArgs {
  const DashboardScreenArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'DashboardScreenArgs{key: $key}';
  }
}

/// generated route for [_i5.DebtScreen]
class DebtScreen extends _i7.PageRouteInfo<void> {
  const DebtScreen() : super(name, path: '/debt-detail');

  static const String name = 'DebtScreen';
}

/// generated route for [_i6.OrderScreen]
class OrderScreen extends _i7.PageRouteInfo<void> {
  const OrderScreen() : super(name, path: '/order-detail');

  static const String name = 'OrderScreen';
}
