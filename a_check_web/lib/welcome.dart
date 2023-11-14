import 'package:a_check_web/teachers.dart';
import 'package:a_check_web/widgets/sidenavbar.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<StatefulWidget> createState() => WelcomeState();
}

class WelcomeState extends State<Welcome> {
  List<Widget> views = const [
    Placeholder(),
    Teachers(),
    Placeholder(),
    Placeholder()
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    void sidenavbarchanged(int index) {
      setState(() {
        selectedIndex = index;
      });
    }

    return Scaffold(
      body: Row(
        children: [
          SideNavBar(onIndexChange: sidenavbarchanged),
          Center(child: views.elementAt(selectedIndex)),
        ],
      ),
    );
  }
}
