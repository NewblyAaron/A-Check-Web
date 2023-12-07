import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/pages/student/student_profile.dart';

import './students_page.dart';
import 'package:flutter/material.dart';

class StudentsPageState extends State<StudentsPage> {
  StudentProfile? studentProfile;

  @override
  Widget build(BuildContext context) => StudentsPageView(this);

  onListRowTap(Student? student) {
    setState(() => studentProfile = student != null ? StudentProfile(studentId: student.id) : null);
  }
}
