import 'package:atm_app/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final FaIcon icon;
  final String label;
  final bool isLoading;
  const CustomActionButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.label,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingWidget()
        : ElevatedButton.icon(
            onPressed: onPressed,
            icon: icon,
            label: Text(label),
          );
  }
}
