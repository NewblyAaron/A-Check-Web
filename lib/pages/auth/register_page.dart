import 'package:a_check_web/globals.dart';
import 'package:a_check_web/model/school.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:a_check_web/utils/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) => RegisterPageView(this);

  @override
  void initState() {
    super.initState();

    emailCon = TextEditingController();
    passwordCon = TextEditingController();
    confirmCon = TextEditingController();
    schoolNameCon = TextEditingController();
    officeNameCon = TextEditingController();
  }

  final formKey = GlobalKey<FormState>();
  late TextEditingController emailCon,
      passwordCon,
      confirmCon,
      schoolNameCon,
      officeNameCon;

  String? confirmPassword(String? value) {
    final hasValue = Validators.hasValue(value);
    if (hasValue != null) {
      return hasValue;
    }

    if (passwordCon.text != confirmCon.text) {
      return "Passwords do not match!";
    }

    return null;
  }

  void register() {
    if (!formKey.currentState!.validate()) return;

    final auth = FirebaseAuth.instance;

    try {
      auth
          .createUserWithEmailAndPassword(
              email: emailCon.text, password: passwordCon.text)
          .then((value) {
        final ref = schoolsRef.doc(value.user!.uid);
        final school = School(
            id: ref.id,
            name: schoolNameCon.text,
            officeName: officeNameCon.text);

        ref.set(school).whenComplete(() {
          snackbarKey.currentState!
              .showSnackBar(const SnackBar(content: Text("Registered!")));
          Navigator.pop(context);
        });
      });
    } on FirebaseAuthException catch (e) {
      snackbarKey.currentState!.showSnackBar(
          SnackBar(content: Text(e.message ?? "Error! ${e.code}")));
    }
  }
}

class RegisterPageView extends WidgetView<RegisterPage, RegisterPageState> {
  const RegisterPageView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 500,
                child: Column(
                  children: [
                    Text("Register"),
                    buildForm(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Form buildForm() {
    return Form(
        key: state.formKey,
        child: Column(
          children: [
            TextFormField(
              controller: state.schoolNameCon,
              validator: Validators.hasValue,
              decoration: InputDecoration(labelText: "School Name"),
            ),
            TextFormField(
              controller: state.officeNameCon,
              validator: Validators.hasValue,
              decoration: InputDecoration(labelText: "Office Name"),
            ),
            TextFormField(
              controller: state.emailCon,
              validator: Validators.isAnEmail,
              decoration: InputDecoration(labelText: "E-mail"),
            ),
            TextFormField(
              controller: state.passwordCon,
              validator: Validators.hasValue,
              decoration: InputDecoration(labelText: "Password"),
            ),
            TextFormField(
              controller: state.confirmCon,
              validator: state.confirmPassword,
              decoration: InputDecoration(labelText: "Confirm Password"),
            ),
            MaterialButton(
              onPressed: state.register,
              child: Text("Register"),
            )
          ],
        ));
  }
}
