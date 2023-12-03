import 'package:a_check_web/forms/class_form.dart';
import 'package:a_check_web/model/school_class.dart';

import 'package:a_check_web/pages/class/class_list.dart';
import 'package:flutter/material.dart';

class ClassListState extends State<ClassList> {
  @override
  Widget build(BuildContext context) => ClassListView(this);

  openForm() async {
    await showDialog(
      context: context,
      builder: (context) => const Dialog(
        child: ClassForm(),
      ),
    );
  }

  onListRowTap(SchoolClass schoolClass) {
    widget.onListRowTap(schoolClass);
  }
}
