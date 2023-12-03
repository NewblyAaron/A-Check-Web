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

  String getPageName() {
    List<String> pageNames = const [
      "Dashboard",
      "Teachers",
      "Students",
      "Classes"
    ];

    return pageNames[selectedIndex];
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
        children: [
          buildNavRail(destinations),
          Expanded(
            child: Column(
              children: [
                buildBar(),
                buildPageView(views),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container buildBar() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: 64,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (child, animation) => SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(0.0, -3),
                          end: const Offset(0.0, 0.0))
                      .animate(animation),
                  child: child),
              child: Text(
                state.getPageName(),
                key: ValueKey<String>(state.getPageName()),
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SearchBar(
              elevation: MaterialStatePropertyAll(1),
              leading: Icon(Icons.search),
              hintText: "Search here...",
            )
          ],
        ));
  }

  NavigationRail buildNavRail(List<NavigationRailDestination> destinations) {
    return NavigationRail(
      destinations: destinations,
      selectedIndex: state.selectedIndex,
      onDestinationSelected: state.onDestinationChanged,
      useIndicator: true,
      extended: true,
      leading: buildLeading(),
    );
  }

  Row buildLeading() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(image: AssetImage("assets/images/small_logo.png"), height: 60),
        Padding(
            padding: EdgeInsets.only(left: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "A-Check",
                  style: TextStyle(fontSize: 24),
                ),
                Text("Web Admin", style: TextStyle(fontSize: 10))
              ],
            ))
      ],
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
