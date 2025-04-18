import 'package:atm_app/core/widgets/bottom_nav_bar.dart';
import 'package:atm_app/features/common/versions/presentation/views/versions_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavView extends StatefulWidget {
  const BottomNavView({super.key});

  @override
  State<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  int pageSelected = 0;
  final _pageController = PageController();

  selecTab(int index) {
    setState(() {
      pageSelected = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  final _pages = [
    const VersionsView(),
    const SettingView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            pageSelected = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: BottomNavBar(
        items: [
          buildBottomNavBarItem(
            icon: const FaIcon(FontAwesomeIcons.house),
            title: const Text('home'),
          ),
          buildBottomNavBarItem(
            icon: const FaIcon(FontAwesomeIcons.gear),
            title: const Text('settings'),
          ),
        ],
        currentIndex: pageSelected,
        onTap: selecTab,
      ),
    );
  }

  buildBottomNavBarItem({required Widget icon, required Widget title}) =>
      SalomonBottomBarItem(
        icon: icon,
        title: title,
      );
}

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Setting View'));
  }
}
