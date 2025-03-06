import 'package:efk_academy/core/constant/constant.dart';
import 'package:flutter/material.dart';

class AppToast {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void error(String text) {
    scaffoldMessengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: red,
          content: Text(
            text,
          ),
        ),
      );
  }

  static void success(String text) {
    scaffoldMessengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: blue,
          content: Text(
            text,
          ),
        ),
      );
  }
}
