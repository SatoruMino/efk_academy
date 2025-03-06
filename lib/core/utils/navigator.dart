import 'package:flutter/material.dart';

class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void push(Widget page) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }

  static void pushReplacement(Widget page) {
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }

  static void popToFirst() {
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }
}
