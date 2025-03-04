import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    super.key,
    required this.progress,
  });

  final double progress;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: progress, // Updates as user progresses
      backgroundColor: Colors.grey[300],
      color: Colors.blue, // Progress color
      minHeight: 6,
    );
  }
}
