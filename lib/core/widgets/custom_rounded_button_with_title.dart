import 'package:flutter/material.dart';

class RoundedButtonWithTitle extends StatelessWidget {
  final Widget icon;
  final String iconName;
  final VoidCallback? onTap;
  const RoundedButtonWithTitle({
    super.key,
    required this.icon,
    required this.iconName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(16),
              backgroundColor: Colors.white,
              side: const BorderSide(
                color: Colors.grey,
              ),
              elevation: 5,
              shadowColor: Colors.grey.withValues(alpha: 0.5),
            ),
            child: icon),
        const SizedBox(
          height: 8,
        ),
        /*Text(
          iconName,
          style: const TextStyle(
            color: kPrimaryColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )*/
      ],
    );
  }
}
