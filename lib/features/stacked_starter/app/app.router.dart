// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../ui/startup/startup_view.dart';
import '../ui/second/second_view.dart';

class Routes {
  static const String startUpView = '/';
  static const String secondView = '/second-view';
  static const all = <String>{
    startUpView,
    secondView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startUpView, page: StartUpView),
    RouteDef(Routes.secondView, page: SecondView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    StartUpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const StartUpView(),
        settings: data,
      );
    },
    SecondView: (data) {
      var args = data.getArgs<SecondViewArguments>(
        orElse: () => SecondViewArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => SecondView(key: args.key),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// SecondView arguments holder class
class SecondViewArguments {
  final Key? key;
  SecondViewArguments({this.key});
}

/// CreateAccountView arguments holder class
class CreateAccountViewArguments {
  final Key? key;
  CreateAccountViewArguments({this.key});
}

/// LoginView arguments holder class
class LoginViewArguments {
  final Key? key;
  LoginViewArguments({this.key});
}
