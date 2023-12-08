import 'package:a_check_web/model/school.dart';
import 'package:flutter/material.dart';

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
  @override
  void initState() {
    super.initState();

    widget.school.ref.classes
        .whereStudentIds(arrayContains: widget.student.id)
        .snapshots()
        .listen((event) {
      if (context.mounted) setState(() {});
    });
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
      appBar: AppBar(
        centerTitle: true,
        title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 0),
                child: Image(
                    image: AssetImage('assets/images/logo_blue.png'),
                    height: 56),
              ),
            ]),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                FutureBuilder(
                    future: getStudentClasses(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: Text("Failed to get enrolled classes"),
                          );
                        }

                        if (snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text("No enrolled classes"),
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
          attendancesWidget != null
              ? Expanded(
                  flex: 1,
                  child: attendancesWidget!,
                )
              : Container()
        ],
      ),
    );
  }
}

class ProfileDropdown extends StatefulWidget {
  const ProfileDropdown({
    super.key,
    required this.onSettingsTap,
    required this.studentName,
    required this.schoolName,
  });

  final String studentName, schoolName;
  final Function()? onSettingsTap;

  @override
  State<ProfileDropdown> createState() => _ProfileDropdownState();
}

class _ProfileDropdownState extends State<ProfileDropdown> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.studentName,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              widget.schoolName,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        PopupMenuButton<String>(
          offset: Offset.zero,
          position: PopupMenuPosition.under,
          icon: const Icon(Icons.arrow_drop_down, size: 25),
          tooltip: 'Profile',
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                onTap: widget.onSettingsTap,
                child: const Text(
                  "Settings",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                ),
              ),
            ];
          },
        ),
      ],
    );
  }
}
