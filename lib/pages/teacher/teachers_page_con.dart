import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/pages/teacher/teacher_info.dart';

import './teachers_page.dart';
import 'package:flutter/material.dart';

class TeachersPageState extends State<TeachersPage> {
  TeacherInfo? teacherInfoWidget;

  @override
  Widget build(BuildContext context) => TeachersPageView(this);

  onListRowTap(Teacher teacher) {
    setState(() => teacherInfoWidget = TeacherInfo(teacher: teacher));
  }
}
