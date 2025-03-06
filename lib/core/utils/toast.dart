import 'package:flutter/material.dart';

class Toast {
  const Toast(this.context);

  final BuildContext context;

  void error(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          content: Text(
            text,
          ),
        ),
      );
  }

  void success(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          content: Text(
            text,
          ),
        ),
      );
  }
}
