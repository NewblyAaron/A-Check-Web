import 'package:a_check_web/forms/class_settings_form.dart';
import 'package:a_check_web/forms/students_form_page.dart';
import 'package:a_check_web/globals.dart';
import 'package:a_check_web/model/school.dart';

import 'package:a_check_web/pages/class/class_profile.dart';
import 'package:flutter/material.dart';

class ClassProfileState extends State<ClassProfile> {
  @override
  Widget build(BuildContext context) => ClassView(this);

  @override
  void initState() {
    super.initState();

    schoolClass = widget.schoolClass;

    classesRef.doc(widget.schoolClass.id).snapshots().listen((event) {
      if (context.mounted) setState(() => schoolClass = event.data!);
    });

    attendancesRef
        .whereClassId(isEqualTo: widget.schoolClass.id)
        .snapshots()
        .listen((event) {
      if (context.mounted) setState(() {});
    });
  }

  late SchoolClass schoolClass;

  int sortColumnIndex = 0;
  bool sortAscending = false;

  void addStudents() async {
    final students = (await studentsRef.get()).docs.map((e) => e.data).toList();
    final enrolledStudents = await schoolClass.getStudents();

    Map<Student, bool> map = {};
    for (var s in students) {
      bool found = false;
      for (var e in enrolledStudents) {
        if (e.id == s.id) {
          found = true;
          map.addAll({s: true});
          break;
        }
      }

      if (found) continue;
      map.addAll({s: false});
    }

    if (!context.mounted) return;

    final List<String>? result = await showDialog(
        context: context,
        builder: (context) => Dialog(
              child: StudentsFormPage(
                  studentsMap: map, key: ValueKey(schoolClass.id)),
            ));

    if (result == null || result.isEmpty) return;

    final newStudentIds = schoolClass.studentIds;
    newStudentIds.addAll(result);

    classesRef
        .doc(schoolClass.id)
        .update(studentIds: newStudentIds)
        .whenComplete(() {
      snackbarKey.currentState!.showSnackBar(SnackBar(
          content: Text(
              "Successfully added ${result.length} student${result.length > 1 ? 's' : ''}.")));
      setState(() {});
    });
  }

  void removeStudents() async {
    final map = {
      for (var element in await schoolClass.getStudents()) element: false
    };

    if (!context.mounted) return;

    final List<String>? result = await showDialog(
        context: context,
        builder: (context) => Dialog(
              child: StudentsFormPage(
                  studentsMap: map,
                  toRemove: true,
                  key: ValueKey(schoolClass.id)),
            ));

    if (result == null || result.isEmpty) return;

    final newStudentIds = schoolClass.studentIds;
    newStudentIds.removeAll(result);

    classesRef
        .doc(schoolClass.id)
        .update(studentIds: newStudentIds)
        .whenComplete(() {
      snackbarKey.currentState!.showSnackBar(SnackBar(
          content: Text(
              "Successfully removed ${result.length} student${result.length > 1 ? 's' : ''}.")));
      setState(() {});
    });
  }

  void openSettings() async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: ClassSettingsForm(schoolClass: schoolClass),
      ),
    );
  }
}
