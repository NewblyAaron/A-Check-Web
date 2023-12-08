import 'package:a_check_web/model/school.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Classes extends StatefulWidget {
  const Classes({super.key, required this.classes, required this.onClassTap});

  final List<SchoolClass> classes;
  final Function(SchoolClass schoolClass) onClassTap;

  @override
  State<Classes> createState() => _ClassesState();
}

class _ClassesState extends State<Classes> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(50, 70, 70, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "List of Enrolled Classes",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 25,
                  color: Color(0xff000000),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(50, 20, 70, 0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.classes.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.class_rounded,
                    size: 40,
                  ),
                  onTap: () => widget.onClassTap(widget.classes[index]),
                  dense: false,
                  contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                  selectedTileColor: Colors.blue.shade100,
                  title: Text(widget.classes[index].name),
                  subtitle: Text(widget.classes[index].section),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class AttendanceRecords extends StatefulWidget {
  const AttendanceRecords(
      {super.key,
      required this.classId,
      required this.school,
      required this.studentId});

  final School school;
  final String studentId, classId;

  @override
  State<AttendanceRecords> createState() => _AttendanceRecordsState();
}

class _AttendanceRecordsState extends State<AttendanceRecords> {
  @override
  void initState() {
    super.initState();

    widget.school.ref.attendances
        .whereStudentId(isEqualTo: widget.studentId)
        .whereClassId(isEqualTo: widget.classId)
        .snapshots()
        .listen((event) {
      if (context.mounted) setState(() {});
    });
  }

  Future<List<AttendanceRecord>> getRecords() {
    return widget.school.ref.attendances
        .whereStudentId(isEqualTo: widget.studentId)
        .whereClassId(isEqualTo: widget.classId)
        .get()
        .then((value) => value.docs.map((e) => e.data).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(50, 70, 70, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Attendance Records",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 25,
                  color: Color(0xff000000),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(50, 20, 70, 0),
          child: FutureBuilder(
            future: getRecords(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text("Failed to get attendances of class"),
                  );
                }

                if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("No records"),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var icon;
                    switch (snapshot.data![index].status) {
                      case AttendanceStatus.Absent:
                        icon = Icons.close;
                        break;
                      case AttendanceStatus.Late:
                        icon = Icons.watch_later;
                        break;
                      case AttendanceStatus.Excused:
                        icon = Icons.assistant_photo;
                        break;
                      default:
                        icon = Icons.fact_check_rounded;
                    }

                    return Card(
                      child: ListTile(
                        leading: Icon(
                          icon,
                          size: 40,
                        ),
                        dense: false,
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 5, 20, 10),
                        selectedTileColor: Colors.blue.shade100,
                        title: Text(DateFormat(DateFormat.YEAR_MONTH_DAY)
                            .format(snapshot.data![index].dateTime)),
                        trailing: Text(snapshot.data![index].status.name),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
