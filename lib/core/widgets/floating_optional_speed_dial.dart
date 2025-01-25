import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../const/app_const.dart';

class FloatingAddOptionsSpeedDial extends StatelessWidget {
  final List<SpeedDialChild> speedDials;
  const FloatingAddOptionsSpeedDial({
    super.key,
    required this.speedDials,
  });

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animationDuration: const Duration(milliseconds: 50),
      childrenButtonSize: const Size(48, 48),
      overlayOpacity: 0.3,
      switchLabelPosition: true,
      direction: SpeedDialDirection.right,
      elevation: 10,
      gradientBoxShape: BoxShape.circle,
      icon: Icons.add,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
      spaceBetweenChildren: 8,
      children: speedDials.map((e) => e).toList(),
    );
  }
}
