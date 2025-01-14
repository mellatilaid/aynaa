import 'package:flutter/material.dart';

class CustomActionButtonType2 extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color backGroundColor;
  final bool isLoading;
  final EdgeInsetsGeometry padding;
  const CustomActionButtonType2({
    super.key,
    required this.title,
    required this.onPressed,
    required this.backGroundColor,
    this.isLoading = false,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.sizeOf(context).width, 30),
          backgroundColor: backGroundColor,
        ),
        onPressed: onPressed,
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
