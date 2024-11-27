import 'package:flutter/material.dart';

showScaffoldMessage(BuildContext context, String message,
    {Duration duration = const Duration(seconds: 3),
    SnackBarBehavior behavior = SnackBarBehavior.fixed}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        behavior: behavior, // Set the behavior (floating or fixed)
      ),
    );
  });
}
