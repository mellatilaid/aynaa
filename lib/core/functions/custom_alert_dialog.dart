import 'package:flutter/material.dart';

customAlertDialog({
  required BuildContext context,
  required Widget title,
  required Widget content,
  required String popButtonTitle,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: title,
      content: content,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(popButtonTitle),
        ),
      ],
    ),
  );
}
