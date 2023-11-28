import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/pages/student/student_info.dart';

import './students_page.dart';
import 'package:flutter/material.dart';

class StudentsPageState extends State<StudentsPage> {
  StudentInfo? studentInfoWidget;

  @override
  Widget build(BuildContext context) => StudentsPageView(this);

  onListRowTap(Student student) {
    setState(() => studentInfoWidget = StudentInfo(student: student));
  }
}
