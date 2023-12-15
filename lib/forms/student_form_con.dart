import 'package:a_check_web/forms/student_form.dart';
import 'package:a_check_web/globals.dart';
import 'package:a_check_web/model/school.dart';
import 'package:flutter/material.dart';

class StudentFormState extends State<StudentForm> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController idCon,
      fNameCon,
      mNameCon,
      lNameCon,
      emailCon,
      phoneNumCon;

  @override
  Widget build(BuildContext context) => StudentFormView(this);

  @override
  void initState() {
    super.initState();

    idCon = TextEditingController();
    fNameCon = TextEditingController();
    mNameCon = TextEditingController();
    lNameCon = TextEditingController();
    emailCon = TextEditingController();
    phoneNumCon = TextEditingController();

    if (widget.student != null) {
      idCon.text = widget.student!.id;
      fNameCon.text = widget.student!.firstName;
      mNameCon.text = widget.student!.middleName;
      lNameCon.text = widget.student!.lastName;
      emailCon.text = widget.student!.email ?? "";
      phoneNumCon.text = widget.student!.phoneNumber ?? "";
    }
  }

  cancel() {
    Navigator.pop(context);
  }

  finalize() async {
    if (!formKey.currentState!.validate()) return;

    final student = Student(
        id: idCon.text,
        firstName: fNameCon.text,
        middleName: mNameCon.text,
        lastName: lNameCon.text,
        email: emailCon.text,
        phoneNumber: phoneNumCon.text,
        faceArray: widget.student?.faceArray,
        photoPath: widget.student?.photoPath);

    studentsRef.doc(student.id).set(student).then((_) {
      snackbarKey.currentState!.showSnackBar(SnackBar(
          content: Text(
              "Successfully ${widget.student != null ? "edited" : "added"} ${student.fullName}!")));
      Navigator.pop(context, student);
    });
  }
}
