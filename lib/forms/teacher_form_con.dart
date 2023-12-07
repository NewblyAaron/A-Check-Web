import 'package:a_check_web/forms/teacher_form.dart';
import 'package:a_check_web/globals.dart';
import 'package:a_check_web/model/person.dart';
import 'package:flutter/material.dart';

class TeacherFormState extends State<TeacherForm> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController idCon,
      fNameCon,
      mNameCon,
      lNameCon,
      emailCon,
      phoneNumCon;

  cancel() {
    Navigator.pop(context);
  }

  finalize() {
    if (!formKey.currentState!.validate()) return;

    final teacher = Teacher(
        id: idCon.text,
        firstName: fNameCon.text,
        middleName: mNameCon.text,
        lastName: lNameCon.text,
        email: emailCon.text,
        phoneNumber: phoneNumCon.text,
        photoPath: widget.teacher?.photoPath);

    teachersRef.doc(teacher.id).set(teacher).then((value) {
      snackbarKey.currentState!.showSnackBar(
          SnackBar(content: Text("Successfully added ${teacher.fullName}!")));
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    super.initState();

    idCon = TextEditingController();
    fNameCon = TextEditingController();
    mNameCon = TextEditingController();
    lNameCon = TextEditingController();
    emailCon = TextEditingController();
    phoneNumCon = TextEditingController();

    if (widget.teacher != null) {
      idCon.text = widget.teacher!.id;
      fNameCon.text = widget.teacher!.firstName;
      mNameCon.text = widget.teacher!.middleName;
      lNameCon.text = widget.teacher!.lastName;
      emailCon.text = widget.teacher!.email ?? "";
      phoneNumCon.text = widget.teacher!.phoneNumber ?? "";
    }
  }

  @override
  Widget build(BuildContext context) => TeacherFormView(this);
}
