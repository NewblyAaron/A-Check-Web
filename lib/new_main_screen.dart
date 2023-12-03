import 'package:a_check_web/dashboard.dart';
import 'package:a_check_web/pages/class/classes_page.dart';
import 'package:a_check_web/pages/student/students_page.dart';
import 'package:a_check_web/pages/teacher/teachers_page.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) => MainScreenView(this);

  int selectedIndex = 0;
  PageController pageController = PageController(
    keepPage: true,
  );

  void onDestinationChanged(int value) {
    setState(() {
      selectedIndex = value;
      pageController.animateToPage(value,
          duration: const Duration(milliseconds: 400), curve: Curves.ease);
    });
  }
}

class MainScreenView extends WidgetView<MainScreen, MainScreenState> {
  const MainScreenView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> views = const [
      Dashboard(),
      TeachersPage(),
      StudentsPage(),
      ClassesPage(),
    ];

    List<NavigationRailDestination> destinations = const [
      NavigationRailDestination(
        icon: Icon(Icons.dashboard_outlined),
        selectedIcon: Icon(Icons.dashboard),
        label: Text("Dashboard"),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.person_outline),
        selectedIcon: Icon(Icons.person),
        label: Text("Teachers"),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.group_outlined),
        selectedIcon: Icon(Icons.group),
        label: Text("Students"),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.grid_view_outlined),
        selectedIcon: Icon(Icons.grid_view_rounded),
        label: Text("Classes"),
      ),
    ];

    return Scaffold(
      body: Row(
        children: [buildNavRail(destinations), buildPageView(views)],
      ),
    );
  }

  NavigationRail buildNavRail(List<NavigationRailDestination> destinations) {
    return NavigationRail(
      destinations: destinations,
      selectedIndex: state.selectedIndex,
      onDestinationSelected: state.onDestinationChanged,
      useIndicator: true,
      extended: true,
      leading: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(image: AssetImage("assets/images/small_logo.png"), height: 60),
          Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text(
                "A-Check",
                style: TextStyle(fontSize: 24),
              ))
        ],
      ),
    );
  }

  Expanded buildPageView(List<Widget> views) {
    return Expanded(
      child: PageView(
        controller: state.pageController,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: views,
      ),
    );
  }
}
