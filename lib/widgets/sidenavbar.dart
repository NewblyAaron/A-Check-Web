import 'package:a_check_web/abstracts.dart';
import 'package:a_check_web/widgets/controllers/sidenavbar_con.dart';
import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';

class SideNavBar extends StatefulWidget {
  const SideNavBar({super.key, required this.onIndexChange});

  final Function(int index) onIndexChange;

  @override
  State<SideNavBar> createState() => SideNavBarState();
}

class SideNavBarView extends WidgetView<SideNavBar, SideNavBarState> {
  const SideNavBarView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [BoxShadow(blurRadius: 2, spreadRadius: 1)]),
      child: SideNavigationBar(
          initiallyExpanded: false,
          selectedIndex: state.selectedIndex,
          items: const [
            SideNavigationBarItem(icon: Icons.home, label: "Dashboard"),
            SideNavigationBarItem(
              icon: Icons.dashboard,
              label: 'Teachers',
            ),
            SideNavigationBarItem(
              icon: Icons.person,
              label: 'Students',
            ),
            SideNavigationBarItem(
              icon: Icons.settings,
              label: 'Classes',
            ),
          ],
          onTap: state.onTap),
    );
  }
}
