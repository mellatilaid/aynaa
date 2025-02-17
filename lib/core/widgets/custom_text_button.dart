import 'package:atm_app/core/const/app_const.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double? width;
  final Color? textColor;
  final bool isLoading;
  const CustomTextButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.width = double.infinity,
    this.textColor = kPrimaryColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextButton(
        onPressed: onPressed,
        child: (isLoading)
            ? const CircularProgressIndicator()
            : Text(
                title,
                style: TextStyle(color: textColor),
              ),
      ),
    );
  }
}
