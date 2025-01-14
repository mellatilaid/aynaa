import 'package:flutter/material.dart';

import '../../const.dart';

class CustomTextButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double? width;
  final Color? textColor;
  const CustomTextButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.width = double.infinity,
    this.textColor = kPrimaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
