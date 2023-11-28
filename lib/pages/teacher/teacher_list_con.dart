import 'package:a_check_web/forms/teacher_form.dart';
import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/pages/teacher/teacher_list.dart';
import 'package:flutter/material.dart';

class TeacherListState extends State<TeacherList> {
  @override
  Widget build(BuildContext context) => TeacherListView(this);

  openForm() async {
    await showDialog(
      context: context,
      builder: (context) => const Dialog(
        child: TeacherForm(),
      ),
    );
  }

  onListRowTap(Teacher teacher) {
    widget.onListRowTap(teacher);
  }
}