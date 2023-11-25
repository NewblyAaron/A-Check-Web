import 'package:a_check_web/forms/teacher_form_con.dart';
import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:a_check_web/utils/validators.dart';
import 'package:flutter/material.dart';

class TeacherForm extends StatefulWidget {
  const TeacherForm({super.key, this.teacher});

  final Teacher? teacher;

  @override
  State<TeacherForm> createState() => TeacherFormState();
}

class TeacherFormView extends WidgetView<TeacherForm, TeacherFormState> {
  const TeacherFormView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 70, 70, 20),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              const Text("Add Teacher",
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
                  decoration: const InputDecoration(labelText: "Teacher ID"),
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
