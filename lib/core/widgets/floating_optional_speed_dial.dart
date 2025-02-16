import 'package:atm_app/core/const/app_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FloatingAddOptionsSpeedDial extends StatelessWidget {
  final List<SpeedDialChild> speedDials;
  const FloatingAddOptionsSpeedDial({
    super.key,
    required this.speedDials,
  });

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      direction: SpeedDialDirection.right, // Expand upwards
      buttonSize: const Size(56, 56),
      childrenButtonSize: const Size(56, 56),
      spacing: 10, // Increase spacing to avoid overlap
      spaceBetweenChildren: 10, // Extra space between items
      animationDuration: const Duration(milliseconds: 300), // Smooth animation
      animationCurve: Curves.easeInOut,
      renderOverlay: true, // Ensure overlay is rendered
      switchLabelPosition: true, // Moves labels above in RTL mode

      children: speedDials.map((e) => e).toList(),
    );
  }
}
