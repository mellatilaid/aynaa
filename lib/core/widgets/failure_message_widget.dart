import 'package:flutter/material.dart';

class FailureMessageWidget extends StatelessWidget {
  final String message;
  const FailureMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
