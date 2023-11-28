import 'package:a_check_web/forms/class_form.dart';
import 'package:flutter/material.dart';

class ClassFormState extends State<ClassForm> {
  @override
  Widget build(BuildContext context) => ClassFormView(this);
  final formKey = GlobalKey<FormState>();

  late TextEditingController codeCon, nameCon, sectionCon;

  @override
  void initState() {
    super.initState();
    codeCon = TextEditingController();
    nameCon = TextEditingController();
    sectionCon = TextEditingController();
  }

  confirmForm() {
    if (!formKey.currentState!.validate()) return;
  }
}
