import 'package:a_check_web/forms/student_form_con.dart';
import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:a_check_web/utils/validators.dart';
import 'package:flutter/material.dart';

class StudentForm extends StatefulWidget {
  const StudentForm({super.key, this.student});

  final Student? student;

  @override
  State<StudentForm> createState() => StudentFormState();
}

class StudentFormView extends WidgetView<StudentForm, StudentFormState> {
  const StudentFormView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(100, 50, 100, 0),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              const Text("Add Student",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    fontSize: 50,
                    color: Color(0xff000000),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: state.idCon,
                  validator: Validators.hasValue,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  decoration: const InputDecoration(labelText: "Student ID"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: state.fNameCon,
                  validator: Validators.hasValue,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  decoration: const InputDecoration(labelText: "First Name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: state.mNameCon,
                  validator: Validators.hasValue,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  decoration: const InputDecoration(labelText: "Middle Name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: state.lNameCon,
                  validator: Validators.hasValue,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  decoration: const InputDecoration(labelText: "Last Name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: state.phoneNumCon,
                  validator: Validators.isAMobileNumber,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  decoration: const InputDecoration(labelText: "Mobile Number"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: state.emailCon,
                  validator: Validators.isAnEmail,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  decoration: const InputDecoration(labelText: "Email Address"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: state.finalize,
                child: const Text(
                  "Confirm",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
