import 'package:a_check_web/model/school.dart';
import 'package:a_check_web/pages/student/student_profile.dart';

import './students_page.dart';
import 'package:flutter/material.dart';

class StudentsPageState extends State<StudentsPage>
    with AutomaticKeepAliveClientMixin {
  StudentProfile? studentProfileWidget;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StudentsPageView(this);
  }

  @override
  bool get wantKeepAlive => true;

  onListRowTap(Student student) {
    setState(() => studentProfileWidget =
        StudentProfile(student: student, key: ValueKey<Student>(student)));
  }

  void closeProfile() {
    setState(() => studentProfileWidget = null);
  }
}
