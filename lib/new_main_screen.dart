import 'package:a_check_web/pages/dashboard/dashboard.dart';
import 'package:a_check_web/pages/class/classes_page.dart';
import 'package:a_check_web/pages/student/students_page.dart';
import 'package:a_check_web/pages/teacher/teachers_page.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  SearchController searchController = SearchController();

  void onDestinationChanged(int value) {
    setState(() {
      selectedIndex = value;
      pageController.animateToPage(value,
          duration: const Duration(milliseconds: 400), curve: Curves.ease);
    });
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  String getSearchName() {
    List<String> pageNames = const [
      "Dashboard",
      "Teachers",
      "Students",
      "Classes"
    ];

    return pageNames[selectedIndex];
  }

  void clearSearch() {
    searchController.clear();
  }
}

class MainScreenView extends WidgetView<MainScreen, MainScreenState> {
  const MainScreenView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> views = [
      const Dashboard(),
      TeachersPage(searchController: state.searchController),
      StudentsPage(searchController: state.searchController),
      ClassesPage(searchController: state.searchController),
    ];

    List<NavigationRailDestination> destinations = const [
      NavigationRailDestination(
        icon: Icon(
          Icons.home_outlined,
          color: Color(0xff353535),
          size: 30,
        ),
        selectedIcon: Icon(
          Icons.home,
          color: Color(0xff153faa),
          size: 30,
        ),
        label: Text(
          "Dashboard",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.person_outline,
          color: Color(0xff353535),
          size: 30,
        ),
        selectedIcon: Icon(
          Icons.person,
          color: Color(0xff153faa),
          size: 30,
        ),
        label: Text(
          "Teachers",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.group_outlined,
          color: Color(0xff353535),
          size: 30,
        ),
        selectedIcon: Icon(
          Icons.group,
          color: Color(0xff153faa),
          size: 30,
        ),
        label: Text(
          "Students",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.grid_view_outlined,
          color: Color(0xff353535),
          size: 30,
        ),
        selectedIcon: Icon(
          Icons.grid_view_rounded,
          color: Color(0xff153faa),
          size: 30,
        ),
        label: Text(
          "Classes",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    ];

    return Scaffold(
      body: Row(
        children: [
          Container(
              decoration: const BoxDecoration(
                  border: Border(right: BorderSide(width: 0.5))),
              child: buildNavRail(destinations)),
          Expanded(
            child: Column(
              children: [
                buildBar(context),
                buildPageView(views),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container buildBar(BuildContext context) {
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
                state.getSearchName(),
                key: ValueKey<String>(state.getSearchName()),
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            buildSearchBar(context)
          ],
        ));
  }

  Widget buildSearchBar(BuildContext context) {
    return SearchBar(
      controller: state.searchController,
      elevation: const MaterialStatePropertyAll(1),
      leading: const Icon(Icons.search),
      hintText: "Search ${state.getSearchName()}...",
      trailing: [
        IconButton(onPressed: state.clearSearch, icon: const Icon(Icons.clear))
      ],
    );
  }

  NavigationRail buildNavRail(List<NavigationRailDestination> destinations) {
    return NavigationRail(
      backgroundColor: Colors.white,
      destinations: destinations,
      selectedIndex: state.selectedIndex,
      onDestinationSelected: state.onDestinationChanged,
      useIndicator: false,
      extended: true,
      leading: buildLeading(),
      trailing: buildTrailing(),
    );
  }

  Row buildLeading() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 40.0, bottom: 30),
          child: Image(
              image: AssetImage("assets/images/small_logo_blue.png"),
              height: 60),
        ),
        Padding(
            padding: EdgeInsets.only(left: 4, top: 30, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "A-Check",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff153faa)),
                ),
                Text("Web Admin", style: TextStyle(fontSize: 10))
              ],
            ))
      ],
    );
  }

  Expanded buildTrailing() {
    return Expanded(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 256,
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.only(bottom: 24, left: 16),
          child: TextButton.icon(
            icon: const Icon(Icons.logout_outlined),
            label: const Text("Log out"),
            onPressed: state.logout,
          ),
        ),
      ],
    ));
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
