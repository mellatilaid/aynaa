import 'package:atm_app/core/const/app_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

SpeedDialChild customSpeedDialChild(
    {required Widget icon, required String label, VoidCallback? onTap}) {
  return SpeedDialChild(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    child: icon,

    // The background color of the mini FAB
    backgroundColor: kPrimaryColor,
    // The foreground color of the mini FAB
    foregroundColor: Colors.white,
    // The label of the mini FAB
    label: label,
    // The action to perform when the mini FAB is tapped
    onTap: onTap,
  );
}
