import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final FaIcon icon;
  final String label;
  const CustomActionButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(label),
    );
  }
}
