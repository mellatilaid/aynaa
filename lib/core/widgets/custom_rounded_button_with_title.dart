import 'package:flutter/material.dart';

class RoundedButtonWithTitle extends StatelessWidget {
  final IconData iconData;
  final String iconName;
  final VoidCallback? onTap;
  const RoundedButtonWithTitle({
    super.key,
    required this.iconData,
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
            padding: const EdgeInsets.all(8),
            backgroundColor: Colors.white,
            side: const BorderSide(
              color: Colors.transparent,
            ),
            elevation: 5,
            shadowColor: Colors.grey.withValues(alpha: 0.5),
          ),
          child: Icon(
            iconData,
            // color: Colors.blue,
            size: 24,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          iconName,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
