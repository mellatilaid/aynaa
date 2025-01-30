import 'package:flutter/material.dart';

class CustomImageFame extends StatelessWidget {
  final Widget child;
  const CustomImageFame({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 300, // Set maximum height
        minHeight: 150, // Set minimum height
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9, // Standard aspect ratio for previews
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: child,
        ),
      ),
    );
  }
}
