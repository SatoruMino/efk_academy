import 'package:flutter/material.dart';

class NavigatorHelper {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void push(String page, {Object? arguments}) {
    navigatorKey.currentState?.pushNamed(
      page,
      arguments: arguments,
    );
  }

  static void pushReplacement(String page, {Object? arguments}) {
    navigatorKey.currentState?.pushReplacementNamed(
      page,
      arguments: arguments,
    );
  }
}
