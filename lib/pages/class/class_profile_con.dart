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

  void deleteClass() async {
    final result = await Dialogs.showConfirmDialog(
        context,
        const Text("Delete Class"),
        const Text(
            "This will delete the class and its related data. Continue?"));
    if (result == null || !result) {
      return;
    }

    (await schoolClass.getAttendanceRecords())
        .forEach((_, attendanceRecords) async {
      for (var record in attendanceRecords) {
        await attendancesRef.doc(record.id).delete();
      }
    });

    if (context.mounted) {
      classesRef.doc(schoolClass.id).delete().then((_) {
        snackbarKey.currentState!.showSnackBar(
            SnackBar(content: Text("Deleted ${schoolClass.id}.")));
        Navigator.pop(context);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      schoolClass = (await classesRef.doc(widget.classId).get()).data!;
    });
  }

  @override
  Widget build(BuildContext context) => ClassView(this);
}
