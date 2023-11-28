import 'package:a_check_web/forms/class_form_con.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:flutter/material.dart';

class ClassForm extends StatefulWidget {
  const ClassForm({super.key});

  @override
  State<ClassForm> createState() => ClassFormState();
}

class ClassFormView extends WidgetView<ClassForm, ClassFormState> {
  const ClassFormView(super.state, {super.key});

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
              const Text("Add Class",
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
                  //controller: state.idCon,
                  //validator: Validators.hasValue,
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
                  decoration: const InputDecoration(labelText: "Code"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  // controller: state.fNameCon,
                  // validator: Validators.hasValue,
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
                  decoration: const InputDecoration(labelText: "Name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  // controller: state.mNameCon,
                  // validator: Validators.hasValue,
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
                  decoration: const InputDecoration(labelText: "Section"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {}, //state.finalize,
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
