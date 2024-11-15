import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavBar extends StatelessWidget {
  final List<SalomonBottomBarItem> items;
  final int currentIndex;
  final Color? color;
  final Function(int) onTap;
  const BottomNavBar(
      {super.key,
      required this.items,
      required this.currentIndex,
      this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      backgroundColor: Colors.grey.shade50,
      selectedItemColor: (color != null) ? color : const Color(0xFF6D9EBD),
      unselectedItemColor: Colors.grey.shade400,
      currentIndex: currentIndex,
      onTap: onTap,
      items: items,
    );
  }
}
