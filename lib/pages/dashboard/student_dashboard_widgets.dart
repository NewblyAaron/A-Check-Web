import 'dart:async';

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
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 40, right: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Enrolled Classes",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                fontSize: 30,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12,),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.fromLTRB(20,16,4,4),
                decoration: const BoxDecoration(
                    boxShadow: [
                      // BoxShadow(
                      //   color: Colors.black38,
                      //   blurRadius: 4,
                      //   blurStyle: BlurStyle.outer,
                      //   offset: Offset(2, 3),
                      // ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(50))
                ),
                child:  GridView.builder(
                    shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 600,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: widget.classes.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => widget.onClassTap(widget.classes[index]),
                      child: Container(
                        width: 530,
                        height: 500,
                        padding: const EdgeInsets.all(14),
                        margin: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38,
                                blurRadius: 3,
                                blurStyle: BlurStyle.outer,
                                offset: Offset(2, 3),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(50))
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(widget.classes[index].name,style: const TextStyle(color:Colors.black, fontWeight: FontWeight.w500, fontSize: 18),),
                            Text(widget.classes[index].section,style: const TextStyle(color:Color(0xff153faa), fontWeight: FontWeight.w400, fontSize: 13),),
                          ],
                        ),
                      ),
                    );
                  }),
                // child: ListView.builder(
                //   shrinkWrap: true,
                //   itemCount: widget.classes.length,
                //   itemBuilder: (context, index) {
                //     return ListTile(
                //       // shape: const RoundedRectangleBorder(
                //       //     borderRadius: BorderRadius.all(Radius.circular(25))
                //       // ),
                //       contentPadding: const EdgeInsets.fromLTRB(40, 5, 20, 5),
                //       hoverColor: Colors.transparent,
                //       selectedTileColor: Colors.blue.shade100,
                //       trailing: const Icon(
                //         Icons.more_horiz_rounded,
                //         color: Colors.white,
                //         size: 26,
                //       ),
                //       onTap: () => widget.onClassTap(widget.classes[index]),
                //       dense: false,
                //       title: Text(widget.classes[index].name,style: const TextStyle(color:Colors.white, fontWeight: FontWeight.w500, fontSize: 18),),
                //       subtitle: Text(widget.classes[index].section,style: const TextStyle(color:Colors.orangeAccent, fontWeight: FontWeight.w400, fontSize: 13),),
                //     );
                //   },
                // ),
              ),
            ),
          ],
        ),
      ),
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
  late StreamSubscription recordsStream;

  @override
  void initState() {
    super.initState();

    recordsStream = widget.school.ref.attendances
        .whereStudentId(isEqualTo: widget.studentId)
        .whereClassId(isEqualTo: widget.classId)
        .snapshots()
        .listen((event) {
      if (context.mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  
    recordsStream.cancel();
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
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 4,
            blurStyle: BlurStyle.outer,
            offset: Offset(2, 3),
          ),
        ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50))
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "Your Attendance Records",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                fontSize: 25,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 6,),
          const Divider(
            height: 12,
            color: Colors.black,
            thickness: 0.1,
          ),
          const SizedBox(height: 6,),
          FutureBuilder(
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
                    Icon icon;
                    switch (snapshot.data![index].status) {
                      case AttendanceStatus.Absent:
                        icon = const Icon(
                          Icons.hdr_auto_outlined,
                          size: 24,
                          color: Colors.redAccent,
                        );
                        break;
                      case AttendanceStatus.Late:
                        icon = const Icon(
                          Icons.dark_mode_outlined,
                          size: 24,
                          color: Colors.orangeAccent,
                        );
                        break;
                      case AttendanceStatus.Excused:
                        icon = const Icon(
                          Icons.flag_circle_outlined,
                          size: 24,
                          color: Colors.purple,
                        );
                        break;
                      default:
                        icon = const Icon(
                          Icons.check_circle,
                          size: 24,
                          color: Colors.green,
                        );
                    }

                    return Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(25))
                      ),
                      child: ListTile(
                        leading: icon,
                        dense: false,
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        title: Text(DateFormat(DateFormat.YEAR_MONTH_DAY)
                            .format(snapshot.data![index].dateTime), style: const TextStyle(color:Colors.black, fontWeight: FontWeight.w400, fontSize: 16),),
                        trailing: Text(snapshot.data![index].status.name,style: const TextStyle(color:Colors.black, fontWeight: FontWeight.w500, fontSize: 13, letterSpacing: 0.2),),
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
        ],
      ),
    );
  }
}
