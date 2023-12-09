import 'dart:async';

import 'package:a_check_web/model/school.dart';
import 'package:a_check_web/pages/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) => DashboardView(this);

  @override
  void initState() {
    super.initState();

    recordsStream = attendancesRef.snapshots().listen((event) {
      if (context.mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  
    recordsStream.cancel();
  }

  late StreamSubscription recordsStream;

  Future<Map<Student, int>> getTotalAbsentStudents() async {
    final students = (await studentsRef.get()).docs.map((e) => e.data).toList();
    Map<Student, int> absentMap = {};

    for (var s in students) {
      final absentValue = (await attendancesRef
              .whereStudentId(isEqualTo: s.id)
              .get())
          .docs
          .where((element) => element.data.status == AttendanceStatus.Absent)
          .length;

      if (absentValue > 0) absentMap.addAll({s: absentValue});
    }

    return Map.fromEntries(absentMap.entries.toList()
      ..sort(
        (a, b) => b.value.compareTo(a.value),
      ));
  }

  Future<Map<SchoolClass, int>> getTotalAbsentClasses() async {
    final classes = (await classesRef.get()).docs.map((e) => e.data).toList();
    Map<SchoolClass, int> absentMap = {};

    for (var c in classes) {
      final absentValue = (await attendancesRef
              .whereClassId(isEqualTo: c.id)
              .get())
          .docs
          .where((element) => element.data.status == AttendanceStatus.Absent)
          .length;

      if (absentValue > 0) absentMap.addAll({c: absentValue});
    }

    return Map.fromEntries(absentMap.entries.toList()
      ..sort(
        (a, b) => b.value.compareTo(a.value),
      ));
  }

  Future<Map<Student, int>> getMostMaxAbsentStudents() async {
    final students = (await studentsRef.get()).docs.map((e) => e.data).toList();
    final classes = (await classesRef.get()).docs.map((e) => e.data).toList();
    Map<Student, int> absentMap = {};

    for (var s in students) {
      int count = 0;
      for (var c in classes) {
        final absentValue = (await attendancesRef
                .whereClassId(isEqualTo: c.id)
                .whereStudentId(isEqualTo: s.id)
                .get())
            .docs
            .where((element) => element.data.status == AttendanceStatus.Absent)
            .length;

        if (absentValue >= c.maxAbsences) count++;
      }

      if (count > 0) absentMap.addAll({s: count});
    }

    return Map.fromEntries(absentMap.entries.toList()
      ..sort(
        (a, b) => b.value.compareTo(a.value),
      ));
  }

  Future<Map<SchoolClass, int>> getMostMaxAbsentClasses() async {
    final students = (await studentsRef.get()).docs.map((e) => e.data).toList();
    final classes = (await classesRef.get()).docs.map((e) => e.data).toList();
    Map<SchoolClass, int> absentMap = {};

    for (var c in classes) {
      int count = 0;
      for (var s in students) {
        final absentValue = (await attendancesRef
                .whereClassId(isEqualTo: c.id)
                .whereStudentId(isEqualTo: s.id)
                .get())
            .docs
            .length;

        if (absentValue >= c.maxAbsences) count++;
      }

      if (count > 0) absentMap.addAll({c: count});
    }

    return Map.fromEntries(absentMap.entries.toList()
      ..sort(
        (a, b) => b.value.compareTo(a.value),
      ));
  }
}
