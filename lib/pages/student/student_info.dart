import 'package:a_check_web/model/person.dart';
import 'package:flutter/material.dart';

class StudentInfo extends StatelessWidget {
  const StudentInfo({super.key, required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(child: Text(student.fullName)),
    );
  }
}
