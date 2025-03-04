import 'package:atm_app/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class CustomActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? icon;
  final String label;
  final bool isLoading;
  const CustomActionButton(
      {super.key,
      required this.onPressed,
      this.icon,
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
