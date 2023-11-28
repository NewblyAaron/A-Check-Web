import 'package:a_check_web/forms/student_form.dart';
import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/pages/student/student_list.dart';
import 'package:flutter/material.dart';

class StudentListState extends State<StudentList> {
  @override
  Widget build(BuildContext context) => StudentListView(this);

  openForm() async {
    await showDialog(
      context: context,
      builder: (context) => const Dialog(
        child: StudentForm(),
      ),
    );
  }

  onListRowTap(Student student) {
    widget.onListRowTap(student);
  }
}