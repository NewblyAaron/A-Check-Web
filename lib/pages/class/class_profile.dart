import 'package:a_check_web/model/school_class.dart';
import 'package:a_check_web/pages/class/class_profile_con.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:a_check_web/widgets/student_card.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:flutter/material.dart';

class ClassProfile extends StatefulWidget {
  const ClassProfile({Key? key, required this.classId}) : super(key: key);
  final String classId;

  @override
  State<ClassProfile> createState() => ClassProfileState();
}

class ClassView extends WidgetView<ClassProfile, ClassProfileState> {
  const ClassView(state, {Key? key}) : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: FirestoreBuilder(
        ref: classesRef.doc(widget.classId),
        builder: (context, snapshot, child) => snapshot.hasData
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  buildHeader(snapshot.data!.data!),
                  buildTabBar(),
                  Expanded(child: buildTabBarView(snapshot.data!.data!))
                ],
              )
            : const Center(child: CircularProgressIndicator()),
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
      margin: const EdgeInsets.fromLTRB(0, 30, 0, 20),
      padding: const EdgeInsets.all(0),
      width: 360,
      decoration: const BoxDecoration(
        color: Color(0x1fffffff),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.zero,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 20),
              child: Text(
                schoolClass.id,
                textAlign: TextAlign.left,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                  fontSize: 24,
                  color: Color(0xff000000),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Text(
              schoolClass.name,
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 26,
                color: Colors.black87,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Text(
              "${schoolClass.section}\n${schoolClass.getSchedule()}",
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 14,
                color: Colors.green,
              ),
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
      ),
    );
  }

  Widget buildStudentsListView(SchoolClass schoolClass) {
    return FutureBuilder(
      future: schoolClass.getStudents(),
      builder: (context, snapshot) => ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        children: snapshot.hasData
            ? snapshot.data!
                .map((e) => StudentCard(
                      student: e,
                      studentClass: schoolClass,
                    ))
                .toList()
            : [const CircularProgressIndicator()],
      ),
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
