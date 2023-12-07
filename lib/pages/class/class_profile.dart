import 'package:a_check_web/model/school_class.dart';
import 'package:a_check_web/pages/class/class_profile_con.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:a_check_web/widgets/student_card.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:flutter/material.dart';

class ClassProfile extends StatefulWidget {
  const ClassProfile({Key? key, required this.schoolClass}) : super(key: key);
  final SchoolClass schoolClass;

  @override
  State<ClassProfile> createState() => ClassProfileState();
}

class ClassView extends WidgetView<ClassProfile, ClassProfileState> {
  const ClassView(state, {Key? key}) : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          buildHeader(widget.schoolClass),
          buildTabBar(),
          Expanded(child: buildTabBarView(widget.schoolClass))
        ],
      ),
    );
  }

  Widget buildTabBar() {
    return const TabBar(
      indicatorColor: Colors.black,
      tabs: [
        Tab(child: Text("Student List", style: TextStyle(color: Colors.black))),
        Tab(
            child: Text("Attendance Records",
                style: TextStyle(color: Colors.black)))
      ],
    );
  }

  Widget buildTabBarView(SchoolClass schoolClass) {
    return TabBarView(
      children: [
        buildStudentsListView(schoolClass),
        const Placeholder(),
        // buildReportsListView(schoolClass)
      ],
    );
  }

  Widget buildHeader(SchoolClass schoolClass) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0x1fffffff),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.zero,
      ),
      child: FutureBuilder(
        future: schoolClass.teacher,
        builder: (context, snapshot) => snapshot.hasData
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        schoolClass.name,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 24,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        schoolClass.section,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      )
                    ],
                  ),
                  Text(
                    snapshot.hasData ? snapshot.data!.fullName : "",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    schoolClass.getSchedule(),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Colors.green,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.green.shade900),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${schoolClass.studentIds.length.toString()} student${schoolClass.studentIds.length > 1 ? "s" : ""}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }

  Widget buildStudentsListView(SchoolClass schoolClass) {
    return FutureBuilder(
      future: schoolClass.getStudents(),
      builder: (context, snapshot) => snapshot.hasData
          ? ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              children: snapshot.data!
                  .map((e) => StudentCard(
                        student: e,
                        studentClass: schoolClass,
                      ))
                  .toList())
          : const Center(child: CircularProgressIndicator()),
    );
  }

  // Widget buildReportsListView(SchoolClass schoolClass) {
  //   return FirestoreBuilder(
  //     ref: attendancesRef.whereClassId(isEqualTo: schoolClass.id),
  //     builder: (context, snapshot, child) => FutureBuilder(
  //       future: schoolClass.getAttendanceRecords(),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           final records = snapshot.data!;

  //           return ListView(
  //             shrinkWrap: true,
  //             padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
  //             children: records.entries
  //                 .map((e) => AttendanceRecordCard(
  //                     dateTime: e.key, attendanceRecords: e.value))
  //                 .toList(),
  //           );
  //         } else {
  //           return const CircularProgressIndicator();
  //         }
  //       },
  //     ),
  //   );
  // }
}
