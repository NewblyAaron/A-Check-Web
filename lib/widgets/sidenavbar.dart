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
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 15),
      decoration: const BoxDecoration(
          color: Colors.white, boxShadow: [BoxShadow(blurRadius: 1)]),
      child: SideNavigationBar(
          header: const SideNavigationBarHeader(
            image: Image(image: AssetImage("assets/images/logo_blue2.png"), height: 60, alignment: Alignment.center,),
            title: Text(''),
            subtitle: Text('')
          ),
        initiallyExpanded: true,
        expandable: false,
        selectedIndex: state.selectedIndex,
        items: const [
          SideNavigationBarItem(icon: Icons.home_filled, label: "Dashboard"),
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
              unselectedItemColor: const Color(0xff353535),
              selectedItemColor: const Color(0xff153faa),
              selectedBackgroundColor: const Color(0xffFAF9FE),
              unselectedBackgroundColor: const Color(0xffFAF9FE),
              iconSize: 25,
              labelTextStyle:
                  const TextStyle(fontSize: 20, color: Colors.black)),
          togglerTheme: SideNavigationBarTogglerTheme.standard(),
          dividerTheme: SideNavigationBarDividerTheme.standard(),
        ),
      ),
    );
  }
}
