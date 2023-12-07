import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/pages/teacher/teacher_profile.dart';

import './teachers_page.dart';
import 'package:flutter/material.dart';

class TeachersPageState extends State<TeachersPage>
    with AutomaticKeepAliveClientMixin {
  TeacherProfile? teacherProfileWidget;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return TeachersPageView(this);
  }

  @override
  bool get wantKeepAlive => true;

  onListRowTap(Teacher teacher) {
    setState(() => teacherProfileWidget =
        TeacherProfile(teacher: teacher, key: ValueKey<Teacher>(teacher)));
  }
}
