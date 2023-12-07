import 'package:a_check_web/model/school_class.dart';
import 'package:a_check_web/pages/teacher/teacher_profile.dart';
import 'package:flutter/material.dart';

class TeacherState extends State<TeacherProfile> {
  @override
  Widget build(BuildContext context) => TeacherView(this);

  Stream<SchoolClassQuerySnapshot> getEnrolledClasses() {
    return classesRef
        .whereTeacherId(isEqualTo: widget.teacher.id)
        .snapshots();
  }
}
