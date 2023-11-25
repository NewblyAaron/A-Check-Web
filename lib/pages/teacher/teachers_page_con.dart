import 'package:a_check_web/forms/teacher_form.dart';

import './teachers_page.dart';
import 'package:flutter/material.dart';

class TeachersPageState extends State<TeachersPage> {
  openForm() async {
    await showDialog(
      context: context,
      builder: (context) => const Dialog(
        child: TeacherForm(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => TeachersPageView(this);
}
