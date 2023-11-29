import 'package:a_check_web/model/school_class.dart';
import 'package:flutter/material.dart';

class ClassInfo extends StatelessWidget {
  const ClassInfo({super.key, required this.schoolClass});

  final SchoolClass schoolClass;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(child: Text("${schoolClass.name} ${schoolClass.section}")),
    );
  }
}
