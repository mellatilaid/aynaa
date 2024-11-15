import 'package:flutter/widgets.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

buildBottomNavBarItem({required Widget icon, required Widget title}) =>
    SalomonBottomBarItem(
      icon: icon,
      title: title,
    );
