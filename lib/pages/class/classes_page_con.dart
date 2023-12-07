import 'package:a_check_web/model/school_class.dart';
import 'package:a_check_web/pages/class/class_profile.dart';
import './classes_page.dart';
import 'package:flutter/material.dart';

class ClassesPageState extends State<ClassesPage>
    with AutomaticKeepAliveClientMixin {
  ClassProfile? classProfile;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ClassesPageView(this);
  }

  @override
  bool get wantKeepAlive => true;

  onListRowTap(SchoolClass schoolClass) {
    setState(() => classProfile = ClassProfile(schoolClass: schoolClass));
  }
}
