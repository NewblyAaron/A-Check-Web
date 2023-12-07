import 'package:a_check_web/model/attendance_record.dart';
import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/pages/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) => DashboardView(this);

  Future<Map<Student, int>> getMostAbsentStudents() async {
    final students = (await studentsRef.get()).docs.map((e) => e.data).toList();
    Map<Student, int> absentMap = {};

    for (var s in students) {
      final absentValue =
          (await attendancesRef.whereStudentId(isEqualTo: s.id).get())
              .docs
              .length;
      absentMap.addAll({s: absentValue});
    }

    return Map.fromEntries(absentMap.entries.toList()
      ..sort(
        (a, b) => a.value.compareTo(b.value),
      ));
  }
}
