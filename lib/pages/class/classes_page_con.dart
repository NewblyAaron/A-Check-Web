import 'package:a_check_web/forms/class_form.dart';
import './classes_page.dart';
import 'package:flutter/material.dart';

class ClassesPageState extends State<ClassesPage> {
  openForm() async {
    await showDialog(
      context: context,
      builder: (context) => const Dialog(
        child: ClassForm(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => ClassesPageView(this);
}
