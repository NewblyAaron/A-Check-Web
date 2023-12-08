import 'package:a_check_web/model/school.dart';
import 'package:a_check_web/pages/class/class_profile_con.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:a_check_web/widgets/attendance_record_card.dart';
import 'package:a_check_web/widgets/student_card.dart';
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
          Stack(children: [
            buildHeader(state.schoolClass),
            Container(
              padding: const EdgeInsets.only(top: 16, right: 64),
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: state.openSettings,
                  icon: const Icon(Icons.settings)),
            ),
          ]),
          buildTabBar(),
          Expanded(child: buildTabBarView(state.schoolClass))
        ],
      ),
    );
  }

  Widget buildTabBar() {
    return const TabBar(
      indicatorColor: Color(0xff153faa),
      tabs: [
        Tab(child: Text("Student List", style: TextStyle(color: Color(0xff153faa)))),
        Tab(
            child: Text("Attendance Records",
                style: TextStyle(color: Color(0xff153faa))))
      ],
    );
  }

  Widget buildTabBarView(SchoolClass schoolClass) {
    return TabBarView(
      children: [
        buildStudentsListView(schoolClass),
        buildReportsListView(schoolClass)
      ],
    );
  }

  Widget buildHeader(SchoolClass schoolClass) {
    return Container(
      padding: const EdgeInsets.only(top: 50),
      margin: const EdgeInsets.all(16),
      child: FutureBuilder(
        future: schoolClass.getTeacher(),
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
                          fontWeight: FontWeight.w600,
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
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xff153faa),
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
                      color:Color(0xff153faa),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      schoolClass.getSchedule(),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color:Colors.black87,
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
                          color:Color(0xff153faa),
                        ),
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
    return Stack(children: [
      FutureBuilder(
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
      ),
      Container(
          alignment: Alignment.bottomRight,
          padding: const EdgeInsets.only(bottom: 16, right: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                onPressed: state.addStudents,
                child: const Icon(Icons.person_add_alt_1),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                onPressed: state.removeStudents,
                child: const Icon(Icons.person_remove_alt_1),
              ),
            ],
          ))
    ]);
  }

  Widget buildReportsListView(SchoolClass schoolClass) {
    return FutureBuilder(
      future: schoolClass.getAttendanceRecords(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final records = snapshot.data!;

            if (records.isEmpty) {
              return const Center(
              child: Text("No records found!"),
            );
            }

            return ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              children: records.entries
                  .map((e) => AttendanceRecordCard(
                      dateTime: e.key, attendanceRecords: e.value))
                  .toList(),
            );
          } else {
            return const Center(
              child: Text("Failed to get attendances of class"),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
