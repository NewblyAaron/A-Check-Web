import 'package:a_check_web/globals.dart';
import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/model/school_class.dart';
import 'package:a_check_web/pages/student/student_profile.dart';
import 'package:a_check_web/utils/dialogs.dart';
import 'package:flutter/material.dart';

class StudentState extends State<StudentProfile> {
  late Student student;

  void showSuccessSnackBar() {
    snackbarKey.currentState!.showSnackBar(SnackBar(
        content: Text("Successfully registered ${student.firstName}'s face!")));
  }

  void showFailedSnackBar(error) {
    snackbarKey.currentState!.showSnackBar(SnackBar(
        content: Text(
            "Something went wrong with saving ${student.firstName}'s face...\n$error")));
  }

  Future<List<SchoolClass>> getEnrolledClasses() async {
    return (await classesRef.whereStudentIds(arrayContains: student.id).get()).docs.map((e) => e.data).toList();
  }

  Future<int> get numberOfEnrolledClasses async {
    return (await classesRef.whereStudentIds(arrayContains: student.id).get()).docs.length;
  }

  void editStudent() {
    // TODO: edit student form
  }

  void deleteStudent() async {
    final result = await Dialogs.showConfirmDialog(
        context,
        const Text("Delete Student"),
        const Text("This will delete the student and its data. Continue?"));

    if (result == null || !result) {
      return;
    }

    if (widget.studentClass != null) {
      final newStudentIds = widget.studentClass!.studentIds;
      newStudentIds.remove(student.id);

      classesRef.doc(widget.studentClass!.id).update(studentIds: newStudentIds);
    }

    if (context.mounted) {
      studentsRef.doc(student.id).delete().then((_) {
        Navigator.pop(context);
      });
    }
  }

  void removeFromClass() async {
    final result = await Dialogs.showConfirmDialog(
        context,
        const Text("Warning"),
        Text(
            "${student.firstName} will be removed to class ${widget.studentClass!.id}. Continue?"));
    if (result == null || !result) {
      return;
    }

    final newStudentIds = widget.studentClass!.studentIds;
    newStudentIds.remove(student.id);

    classesRef
        .doc(widget.studentClass!.id)
        .update(studentIds: newStudentIds)
        .then((_) {
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    super.initState();

    _initStudent();
  }

  void _initStudent() {
    studentsRef.doc(widget.studentId).get().then((value) {
      setState(() => student = value.data!);
    });
  }

  @override
  Widget build(BuildContext context) => StudentView(this);
}
