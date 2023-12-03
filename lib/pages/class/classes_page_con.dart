import 'package:a_check_web/model/school_class.dart';
import 'package:a_check_web/pages/class/class_profile.dart';
import './classes_page.dart';
import 'package:flutter/material.dart';

class ClassesPageState extends State<ClassesPage> {
  ClassProfile? classProfile;

  @override
  Widget build(BuildContext context) => ClassesPageView(this);
  onListRowTap(SchoolClass schoolClass) {
    setState(() => classProfile = ClassProfile(classId: schoolClass.id));
  }
}
