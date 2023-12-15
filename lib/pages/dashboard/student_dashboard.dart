import 'dart:async';

import 'package:a_check_web/model/school.dart';
import 'package:flutter/material.dart';

import '../auth/login_page.dart';
import 'student_dashboard_widgets.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard(
      {super.key, required this.school, required this.student});

  final School school;
  final Student student;

  @override
  State<StatefulWidget> createState() => StudentDashboardState();
}

int selectedIndex = 0;

class StudentDashboardState extends State<StudentDashboard> {
  late StreamSubscription classesStream;

  @override
  void initState() {
    super.initState();

    classesStream = widget.school.ref.classes
        .whereStudentIds(arrayContains: widget.student.id)
        .snapshots()
        .listen((event) {
      if (context.mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();

    classesStream.cancel();
  }

  AttendanceRecords? attendancesWidget;

  Future<List<SchoolClass>> getStudentClasses() {
    return widget.school.ref.classes
        .whereStudentIds(arrayContains: widget.student.id)
        .get()
        .then((value) => value.docs.map((e) => e.data).toList());
  }

  onClassTap(SchoolClass schoolClass) {
    setState(() => attendancesWidget = AttendanceRecords(
          studentId: widget.student.id,
          classId: schoolClass.id,
          school: widget.school,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        primary: false,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: TextButton.icon (
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              icon: const Icon(Icons.logout_rounded, size: 24, color: Colors.black54, ),
              label: const Text("Log out"),
            ),
          ),
        ],
        elevation: 0.5,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40.0, bottom: 30),
              child: Image(
                  image: AssetImage("assets/images/small_logo_blue.png"),
                  height: 50),
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
                          color: Color(0xff153faa)
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 1,child: Container(color: Colors.white,)),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                FutureBuilder(
                    future: getStudentClasses(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: Text("Failed to get enrolled classes", style: TextStyle(fontWeight: FontWeight.w600),),
                          );
                        }

                        if (snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text("You have no enrolled classes."),
                          );
                        }

                        return Classes(
                          classes: snapshot.data!,
                          onClassTap: onClassTap,
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ],
            ),
          ),
          const VerticalDivider(
            color: Colors.black,
            thickness: 0.1,
          ),
          attendancesWidget != null
              ? Expanded(
                flex: 2,
                child: Container(color: Colors.white,child: attendancesWidget!),
              )
              : Expanded(flex: 2,child: Container(color: Colors.white,))
        ],
      ),

    );
  }
}
