// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;

import '../screens/add_debt.dart' as _i7;
import '../screens/add_order.dart' as _i8;
import '../screens/authentication/sign_in_screen.dart' as _i2;
import '../screens/authentication/sign_up_screen.dart' as _i3;
import '../screens/dashboard_screen.dart' as _i4;
import '../screens/debt_screen.dart' as _i5;
import '../screens/order_screen.dart' as _i6;
import '../screens/wrapper/authentication_wrapper_screen.dart' as _i1;

class AppRouter extends _i9.RootStackRouter {
  AppRouter([_i10.GlobalKey<_i10.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    AuthenticationWrapperScreen.name: (routeData) {
      return _i9.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i1.AuthenticationWrapperScreen(),
          transitionsBuilder: _i9.TransitionsBuilders.slideRightWithFade,
          opaque: true,
          barrierDismissible: false);
    },
    SignInScreen.name: (routeData) {
      return _i9.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i2.SignInScreen(),
          opaque: true,
          barrierDismissible: false);
    },
    SignUpScreen.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.SignUpScreen());
    },
    DashboardScreen.name: (routeData) {
      final args = routeData.argsAs<DashboardScreenArgs>(
          orElse: () => const DashboardScreenArgs());
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.DashboardScreen(key: args.key));
    },
    DebtScreen.name: (routeData) {
      final args = routeData.argsAs<DebtScreenArgs>();
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.DebtScreen(key: args.key, debtId: args.debtId));
    },
    OrderScreen.name: (routeData) {
      final args = routeData.argsAs<OrderScreenArgs>();
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.OrderScreen(key: args.key, orderId: args.orderId));
    },
    AddDebt.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.AddDebt());
    },
    AddOrder.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.AddOrder());
    }
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig('/#redirect',
            path: '/', redirectTo: '/wrapper', fullMatch: true),
        _i9.RouteConfig(AuthenticationWrapperScreen.name, path: '/wrapper'),
        _i9.RouteConfig(SignInScreen.name, path: '/signin'),
        _i9.RouteConfig(SignUpScreen.name, path: '/signup'),
        _i9.RouteConfig(DashboardScreen.name, path: '/dashboard'),
        _i9.RouteConfig(DebtScreen.name, path: '/debt-detail'),
        _i9.RouteConfig(OrderScreen.name, path: '/order-detail'),
        _i9.RouteConfig(AddDebt.name, path: '/add-debt'),
        _i9.RouteConfig(AddOrder.name, path: '/add-order')
      ];
}

/// generated route for [_i1.AuthenticationWrapperScreen]
class AuthenticationWrapperScreen extends _i9.PageRouteInfo<void> {
  const AuthenticationWrapperScreen() : super(name, path: '/wrapper');

  static const String name = 'AuthenticationWrapperScreen';
}

/// generated route for [_i2.SignInScreen]
class SignInScreen extends _i9.PageRouteInfo<void> {
  const SignInScreen() : super(name, path: '/signin');

  static const String name = 'SignInScreen';
}

/// generated route for [_i3.SignUpScreen]
class SignUpScreen extends _i9.PageRouteInfo<void> {
  const SignUpScreen() : super(name, path: '/signup');

  static const String name = 'SignUpScreen';
}

/// generated route for [_i4.DashboardScreen]
class DashboardScreen extends _i9.PageRouteInfo<DashboardScreenArgs> {
  DashboardScreen({_i10.Key? key})
      : super(name, path: '/dashboard', args: DashboardScreenArgs(key: key));

  static const String name = 'DashboardScreen';
}

class DashboardScreenArgs {
  const DashboardScreenArgs({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return 'DashboardScreenArgs{key: $key}';
  }
}

/// generated route for [_i5.DebtScreen]
class DebtScreen extends _i9.PageRouteInfo<DebtScreenArgs> {
  DebtScreen({_i10.Key? key, required String debtId})
      : super(name,
            path: '/debt-detail',
            args: DebtScreenArgs(key: key, debtId: debtId));

  static const String name = 'DebtScreen';
}

class DebtScreenArgs {
  const DebtScreenArgs({this.key, required this.debtId});

  final _i10.Key? key;

  final String debtId;

  @override
  String toString() {
    return 'DebtScreenArgs{key: $key, debtId: $debtId}';
  }
}

/// generated route for [_i6.OrderScreen]
class OrderScreen extends _i9.PageRouteInfo<OrderScreenArgs> {
  OrderScreen({_i10.Key? key, required String orderId})
      : super(name,
            path: '/order-detail',
            args: OrderScreenArgs(key: key, orderId: orderId));

  static const String name = 'OrderScreen';
}

class OrderScreenArgs {
  const OrderScreenArgs({this.key, required this.orderId});

  final _i10.Key? key;

  final String orderId;

  @override
  String toString() {
    return 'OrderScreenArgs{key: $key, orderId: $orderId}';
  }
}

/// generated route for [_i7.AddDebt]
class AddDebt extends _i9.PageRouteInfo<void> {
  const AddDebt() : super(name, path: '/add-debt');

  static const String name = 'AddDebt';
}

/// generated route for [_i8.AddOrder]
class AddOrder extends _i9.PageRouteInfo<void> {
  const AddOrder() : super(name, path: '/add-order');

  static const String name = 'AddOrder';
}
