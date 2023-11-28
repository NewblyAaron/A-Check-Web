import 'package:a_check_web/model/school_class.dart';
import 'package:a_check_web/pages/class/class_info.dart';
import './classes_page.dart';
import 'package:flutter/material.dart';

class ClassesPageState extends State<ClassesPage> {
  ClassInfo? classInfoWidget;

  @override
  Widget build(BuildContext context) => ClassesPageView(this);
  onListRowTap(SchoolClass schoolClass) {
    setState(() => classInfoWidget = ClassInfo(schoolClass: schoolClass));
  }
}
