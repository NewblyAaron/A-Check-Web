import 'package:a_check_web/dashboard.dart';
import 'package:a_check_web/pages/student/students_page.dart';
import 'package:a_check_web/pages/teacher/teachers_page.dart';
import 'package:a_check_web/pages/class/classes_page.dart';
import 'package:a_check_web/widgets/sidenavbar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  List<Widget> views = const [
    Dashboard(),
    TeachersPage(),
    StudentsPage(),
    ClassesPage(),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    void sideNavbarChanged(int index) {
      setState(() {
        selectedIndex = index;
      });
    }

    return Scaffold(
      body: Row(
        children: [
          SideNavBar(onIndexChange: sideNavbarChanged),
          Expanded(
            child: views.elementAt(selectedIndex),
          ),
        ],
      ),
    );
  }
}
