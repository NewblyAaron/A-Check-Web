import 'package:a_check_web/forms/student_form.dart';

import './students_page.dart';
import 'package:flutter/material.dart';

class StudentsPageState extends State<StudentsPage> {
  
  openForm() async {
    await showDialog(
      context: context,
      builder: (context) => const Dialog(
        child: StudentForm(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => StudentsPageView(this);
}
