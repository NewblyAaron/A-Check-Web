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
      child: SizedBox(
        width: 600,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(8, 16,8,16),
                      child: Text("Add Teacher",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            fontSize: 35,
                            color: Color(0xff000000),
                          )),
                    ),
                    SizedBox(
                      width: 600,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
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
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              hintText: 'e.g. 202010824',
                              labelText: "Teacher ID number"
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 600,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
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
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              hintText: 'e.g. Aaron',
                              labelText: "First Name"
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 600,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
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
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              hintText: 'e.g. Marcos',
                              labelText: "Middle Name"
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 600,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
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
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              hintText: 'e.g. De La Cruz',
                              labelText: "Last Name"
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 600,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
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
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              hintText: 'e.g. 09123456789',
                              labelText: "Mobile Number"
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 600,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
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
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              hintText: 'e.g. adelacruz@gmail.com',
                              labelText: "E-mail Address"
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Material(
                          color: Colors.grey.shade200,
                          child: InkWell(
                            hoverColor: Colors.grey.withOpacity(0.4),
                            highlightColor: Colors.grey.withOpacity(0.4),
                            splashColor: Colors.grey.withOpacity(0.5),
                            onTap: state.cancel,
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              width:300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                // adding color will hide the splash effect
                                // color: Colors.blueGrey.shade200,
                              ),
                              child: const Text("Cancel", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.lightGreen.shade200,
                          child: InkWell(
                            hoverColor: Colors.green.withOpacity(0.4),
                            highlightColor: Colors.green.withOpacity(0.4),
                            splashColor: Colors.green.withOpacity(0.5),
                            onTap: state.finalize,
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              width:300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                // adding color will hide the splash effect
                                // color: Colors.blueGrey.shade200,
                              ),
                              child: const Text("Confirm", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500), ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
