import 'package:a_check_web/utils/abstracts.dart';
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
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 1)]),
      child:  SideNavigationBar(
          initiallyExpanded: true,
          selectedIndex: state.selectedIndex,
          items: const [
            SideNavigationBarItem(icon: Icons.home, label: "Dashboard"),
            SideNavigationBarItem(
              icon: Icons.people_rounded,
              label: 'Teachers',
            ),
            SideNavigationBarItem(
              icon: Icons.person_rounded,
              label: 'Students',
            ),
            SideNavigationBarItem(
              icon: Icons.class_rounded,
              label: 'Classes',
            ),
          ],
          onTap: state.onTap,
        theme: SideNavigationBarTheme(
          itemTheme: SideNavigationBarItemTheme(
              unselectedItemColor: Colors.black54,
              selectedItemColor: Colors.green,
              iconSize: 30,
              labelTextStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.black
              )
          ),
          togglerTheme: SideNavigationBarTogglerTheme.standard(),
          dividerTheme: SideNavigationBarDividerTheme.standard(),
        ),
      ),
    );
  }
}
