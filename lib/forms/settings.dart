import 'package:a_check_web/globals.dart';
import 'package:a_check_web/model/school.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:a_check_web/utils/validators.dart';
import 'package:flutter/material.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => SettingsFormState();
}

class SettingsFormState extends State<SettingsForm> {
  @override
  Widget build(BuildContext context) => SettingsFormView(this);

  @override
  void initState() {
    super.initState();

    schoolNameCon = TextEditingController();
    officeNameCon = TextEditingController();

    schoolRef.get().then((value) {
      if (context.mounted) {
        setState(() {
          schoolNameCon.text = value.data!.name;
          officeNameCon.text = value.data!.name;
        });
      }
    });
  }

  final formKey = GlobalKey<FormState>();
  late TextEditingController schoolNameCon, officeNameCon;

  void cancel() {
    Navigator.pop(context);
  }

  void finalize() async {
    if (!formKey.currentState!.validate()) return;

    await schoolRef.update(name: schoolNameCon.text, officeName: officeNameCon.text);

    if (context.mounted) {
      snackbarKey.currentState!.showSnackBar(
          const SnackBar(content: Text("Saved profile settings!")));
      Navigator.pop(context);
    }
  }
}

class SettingsFormView extends WidgetView<SettingsForm, SettingsFormState> {
  const SettingsFormView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildForm(),
          const SizedBox(
            height: 48,
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
              child: Text("Profile Settings",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    fontSize: 35,
                    color: Color(0xff000000),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: state.schoolNameCon,
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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    hintText: 'Enter the school name!',
                    labelText: "School Name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: state.officeNameCon,
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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    hintText: 'Enter the office name!',
                    labelText: "Office Name"),
              ),
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
