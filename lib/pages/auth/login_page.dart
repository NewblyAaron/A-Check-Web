import 'package:a_check_web/globals.dart';
import 'package:a_check_web/pages/auth/register_page.dart';
import 'package:a_check_web/pages/auth/student_login_page.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:a_check_web/utils/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) => LoginPageView(this);

  @override
  void initState() {
    super.initState();

    emailCon = TextEditingController();
    passwordCon = TextEditingController();
  }

  final formKey = GlobalKey<FormState>();
  late TextEditingController emailCon, passwordCon;

  void login() async {
    final auth = FirebaseAuth.instance;

    try {
      await auth.signInWithEmailAndPassword(
          email: emailCon.text, password: passwordCon.text);
    } on FirebaseAuthException catch (e) {
      snackbarKey.currentState!.showSnackBar(
          SnackBar(content: Text(e.message ?? "Error! ${e.code}")));
    }
  }

  void register() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RegisterPage(),
        ));
  }

  void studentLogin() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const StudentLoginPage(),
        ));
  }
}

class LoginPageView extends WidgetView<LoginPage, LoginPageState> {
  const LoginPageView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Text("Login"),
                    buildForm(),
                    Row(
                      children: [
                        TextButton(
                            onPressed: state.register, child: Text("Register")),
                        TextButton(
                            onPressed: state.studentLogin,
                            child: Text("Student Login")),
                      ],
                    )
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
              controller: state.emailCon,
              validator: Validators.isAnEmail,
              decoration: InputDecoration(labelText: "E-mail"),
            ),
            TextFormField(
              controller: state.passwordCon,
              validator: Validators.hasValue,
              obscureText: true,
              obscuringCharacter: '●',
              decoration: InputDecoration(labelText: "Password"),
            ),
            MaterialButton(
              onPressed: state.login,
              child: Text("Log in"),
            )
          ],
        ));
  }
}
