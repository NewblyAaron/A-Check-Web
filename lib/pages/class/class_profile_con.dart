import 'package:a_check_web/forms/class_settings_form.dart';
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
  }

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

  void openSettings() async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: ClassSettingsForm(schoolClass: schoolClass),
      ),
    );
  }
}
