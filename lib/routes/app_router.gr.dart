// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../screens/authentication/sign_in_screen.dart' as _i1;
import '../screens/authentication/sign_up_screen.dart' as _i2;
import '../screens/dashboard_screen.dart' as _i3;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    SignInScreen.name: (routeData) {
      return _i4.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i1.SignInScreen(),
          transitionsBuilder: _i4.TransitionsBuilders.slideRightWithFade,
          opaque: true,
          barrierDismissible: false);
    },
    SignUpScreen.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.SignUpScreen());
    },
    DashboardScreen.name: (routeData) {
      final args = routeData.argsAs<DashboardScreenArgs>(
          orElse: () => const DashboardScreenArgs());
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.DashboardScreen(key: args.key));
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig('/#redirect',
            path: '/', redirectTo: '/signin', fullMatch: true),
        _i4.RouteConfig(SignInScreen.name, path: '/signin'),
        _i4.RouteConfig(SignUpScreen.name, path: '/signup'),
        _i4.RouteConfig(DashboardScreen.name, path: '/dashboard')
      ];
}

/// generated route for [_i1.SignInScreen]
class SignInScreen extends _i4.PageRouteInfo<void> {
  const SignInScreen() : super(name, path: '/signin');

  static const String name = 'SignInScreen';
}

/// generated route for [_i2.SignUpScreen]
class SignUpScreen extends _i4.PageRouteInfo<void> {
  const SignUpScreen() : super(name, path: '/signup');

  static const String name = 'SignUpScreen';
}

/// generated route for [_i3.DashboardScreen]
class DashboardScreen extends _i4.PageRouteInfo<DashboardScreenArgs> {
  DashboardScreen({_i5.Key? key})
      : super(name, path: '/dashboard', args: DashboardScreenArgs(key: key));

  static const String name = 'DashboardScreen';
}

class DashboardScreenArgs {
  const DashboardScreenArgs({this.key});

  final _i5.Key? key;

  @override
  String toString() {
    return 'DashboardScreenArgs{key: $key}';
  }
}
