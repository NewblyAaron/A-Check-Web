import 'package:a_check_web/globals.dart';
import 'package:a_check_web/model/attendance_record.dart';
import 'package:a_check_web/model/school_class.dart';
import 'package:a_check_web/utils/dialogs.dart';
import 'package:a_check_web/pages/class/class_profile.dart';
import 'package:flutter/material.dart';

class ClassProfileState extends State<ClassProfile> {
  late SchoolClass schoolClass;

  void backButtonPressed() {
    Navigator.pop(context);
  }

  void addStudent() async {
    // TODO: add student to class
    // final List<String>? result = await Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => const StudentsFormPage()));

    // if (result == null || result.isEmpty) return;

    // final newStudentIds = schoolClass.studentIds;
    // newStudentIds.addAll(result);

    // classesRef
    //     .doc(schoolClass.id)
    //     .update(studentIds: newStudentIds)
    //     .whenComplete(() => setState(() {}));
  }

  void editClass() {
    // TODO: edit class
  }

  @override
  Widget build(BuildContext context) => ClassView(this);
}
