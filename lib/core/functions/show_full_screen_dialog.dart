import 'package:flutter/material.dart';

Future<Object?> fullScreenDialog(BuildContext context,
    {required Widget child}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Full Screen Dialog",
    pageBuilder: (context, animation, secondaryAnimation) {
      return child;
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position:
            Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0))
                .animate(animation),
        child: child,
      );
    },
  );
}
