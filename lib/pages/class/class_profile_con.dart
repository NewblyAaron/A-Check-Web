import 'package:a_check_web/forms/class_settings_form.dart';
import 'package:a_check_web/forms/students_form_page.dart';
import 'package:a_check_web/model/attendance_record.dart';
import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/model/school_class.dart';
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
      setState(() => schoolClass = event.data!);
    });

    attendancesRef
        .whereClassId(isEqualTo: widget.schoolClass.id)
        .snapshots()
        .listen((event) {
      setState(() {});
    });
  }

  late SchoolClass schoolClass;

  int sortColumnIndex = 0;
  bool sortAscending = false;

  void addStudent() async {
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
        .whenComplete(() => setState(() {}));
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
