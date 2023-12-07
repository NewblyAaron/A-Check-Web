import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/model/school_class.dart';
import 'package:a_check_web/pages/student/student_profile.dart';
import 'package:a_check_web/utils/dialogs.dart';
import 'package:flutter/material.dart';

class StudentState extends State<StudentProfile> {
  @override
  Widget build(BuildContext context) => StudentView(this);

  Stream<SchoolClassQuerySnapshot> getEnrolledClasses() {
    return classesRef.whereStudentIds(arrayContains: widget.student.id).snapshots();
  }

  void removeFromClass() async {
    final result = await Dialogs.showConfirmDialog(
        context,
        const Text("Warning"),
        Text(
            "${widget.student.firstName} will be removed to class ${widget.studentClass!.id}. Continue?"));
    if (result == null || !result) {
      return;
    }

    final newStudentIds = widget.studentClass!.studentIds;
    newStudentIds.remove(widget.student.id);

    classesRef
        .doc(widget.studentClass!.id)
        .update(studentIds: newStudentIds)
        .then((_) {
      Navigator.pop(context);
    });
  }
}
