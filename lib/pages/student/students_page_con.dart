import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/pages/student/student_profile.dart';

import './students_page.dart';
import 'package:flutter/material.dart';

class StudentsPageState extends State<StudentsPage>
    with AutomaticKeepAliveClientMixin {
  StudentProfile? studentProfile;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StudentsPageView(this);
  }

  @override
  bool get wantKeepAlive => true;

  onListRowTap(Student? student) {
    setState(() {
      studentProfile = student != null
          ? StudentProfile(
              student: student,
              key: ValueKey<Student>(student),
            )
          : null;
    });
  }
}
