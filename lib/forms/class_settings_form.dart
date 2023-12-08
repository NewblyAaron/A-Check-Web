import 'package:a_check_web/globals.dart';
import 'package:a_check_web/model/school.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:a_check_web/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClassSettingsForm extends StatefulWidget {
  const ClassSettingsForm({super.key, required this.schoolClass});

  final SchoolClass schoolClass;

  @override
  State<ClassSettingsForm> createState() => ClassSettingsState();
}

class ClassSettingsState extends State<ClassSettingsForm> {
  @override
  Widget build(BuildContext context) => ClassSettingsView(this);

  @override
  void initState() {
    super.initState();

    maxAbsenceCon = TextEditingController();

    maxAbsenceCon.text = widget.schoolClass.maxAbsences.toString();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController maxAbsenceCon;

  cancel() {
    Navigator.pop(context);
  }

  finalize() {
    if (!formKey.currentState!.validate()) return;

    classesRef
        .doc(widget.schoolClass.id)
        .update(maxAbsences: int.parse(maxAbsenceCon.text))
        .then((_) {
      snackbarKey.currentState!.showSnackBar(SnackBar(
          content: Text(
              "Successfully edited ${widget.schoolClass.id}'s settings!")));
      Navigator.pop(context);
    });
  }
}

class ClassSettingsView
    extends WidgetView<ClassSettingsForm, ClassSettingsState> {
  const ClassSettingsView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildForm(),
          const SizedBox(
            height: 32,
          ),
          buildButtons()
        ],
      ),
    );
  }

  Form buildForm() {
    return Form(
      key: state.formKey,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 32),
              child: Text("Class Settings",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    fontSize: 35,
                    color: Color(0xff000000),
                  )),
            ),
            TextFormField(
              controller: state.maxAbsenceCon,
              validator: Validators.hasValue,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  hintText: 'Default value: 3',
                  labelText: "Maximum allowable absences"),
            )
          ],
        ),
      ),
    );
  }

  Row buildButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Material(
          color: Colors.grey.shade200,
          child: InkWell(
            hoverColor: Colors.red.withOpacity(0.4),
            highlightColor: Colors.red.withOpacity(0.4),
            splashColor: Colors.red.withOpacity(0.5),
            onTap: state.cancel,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 24),
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                // adding color will hide the splash effect
                // color: Colors.blueGrey.shade200,
              ),
              child: const Text(
                "Cancel",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
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
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                // adding color will hide the splash effect
                // color: Colors.blueGrey.shade200,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Confirm",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
