import 'package:a_check_web/forms/teacher_form.dart';
import 'package:a_check_web/globals.dart';
import 'package:a_check_web/model/school.dart';
import 'package:a_check_web/utils/dialogs.dart';
import 'package:flutter/material.dart';

class TeacherFormState extends State<TeacherForm> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController idCon,
      fNameCon,
      mNameCon,
      lNameCon,
      emailCon,
      passwordCon,
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
        password: passwordCon.text,
        photoPath: widget.teacher?.photoPath,);

    teachersRef.doc(teacher.id).set(teacher).then((value) {
      snackbarKey.currentState!.showSnackBar(
          SnackBar(content: Text("Successfully added ${teacher.fullName}!")));
      Navigator.pop(context);
    });
  }

  void resetPassword() async {
    final result = await Dialogs.showConfirmDialog(context, const Text("Reset password"), const Text("Reset this teacher's password to 123?"));

    if (result ?? false) {
      passwordCon.text = "123";
    }
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
    passwordCon = TextEditingController();

    if (widget.teacher != null) {
      idCon.text = widget.teacher!.id;
      fNameCon.text = widget.teacher!.firstName;
      mNameCon.text = widget.teacher!.middleName;
      lNameCon.text = widget.teacher!.lastName;
      emailCon.text = widget.teacher!.email ?? "";
      passwordCon.text = widget.teacher!.password;
      phoneNumCon.text = widget.teacher!.phoneNumber ?? "";
    }
  }

  @override
  Widget build(BuildContext context) => TeacherFormView(this);
}
