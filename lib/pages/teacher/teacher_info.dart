import 'package:a_check_web/model/person.dart';
import 'package:flutter/material.dart';

class TeacherInfo extends StatelessWidget {
  const TeacherInfo({super.key, required this.teacher});

  final Teacher teacher;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(child: Text(teacher.fullName)),
    );
  }
}
