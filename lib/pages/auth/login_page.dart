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
    return Center(
      child: Card(
        color: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SizedBox(
            width: 350,
            height: 570,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: 450,
                        height: 570,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 35, bottom: 30),
                              child: Image(
                                  image: AssetImage(
                                      "assets/images/small_logo_blue.png"),
                                  height: 100),
                            ),
                            const Text(
                              "Log in to A-Check",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 24),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            buildForm(),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                const Row(
                                  children: [
                                    Expanded(child: Divider()),
                                    Text("     or     "),
                                    Expanded(child: Divider()),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  // hoverColor: const Color(0xff153faa).withOpacity(0.8),
                                  // highlightColor: const Color(0xff153faa).withOpacity(0.4),
                                  // splashColor: const Color(0xff153faa).withOpacity(1),
                                  onTap: state.studentLogin,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    width: 350,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35),
                                      border: Border.all(
                                        color: const Color(0xff153faa),
                                        width: 1,
                                      ),
                                      // adding color will hide the splash effect
                                      color: Colors.transparent,
                                    ),
                                    child: const Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.account_circle_rounded,
                                          color: Color(0xff153faa),
                                          size: 23,
                                        ),
                                        SizedBox(
                                          width: 9,
                                        ),
                                        Text(
                                          "Log in as a Student",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff153faa)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                const Row(
                                  children: [
                                    Expanded(child: Divider()),
                                    Text("     or     "),
                                    Expanded(child: Divider()),
                                  ],
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Don't have a school account?"),
                                    MaterialButton(
                                        minWidth: 30,
                                        onPressed: state.register,
                                        hoverColor: Colors.transparent,
                                        child: const Text(
                                          "Register",
                                          style: TextStyle(
                                              color: Color(0xff153faa),
                                              fontWeight: FontWeight.w500,
                                              decoration:
                                                  TextDecoration.underline),
                                        )),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.email_rounded,
                  color: Colors.black54,
                  size: 20,
                ),
                labelText: "Email",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: state.passwordCon,
              validator: Validators.hasValue,
              obscureText: true,
              obscuringCharacter: '●',
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.key,
                    color: Colors.black54,
                    size: 20,
                  ),
                  labelText: "Password"),
            ),
            const SizedBox(height: 12),
            InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              // hoverColor: const Color(0xff153faa).withOpacity(0.8),
              // highlightColor: const Color(0xff153faa).withOpacity(0.4),
              // splashColor: const Color(0xff153faa).withOpacity(1),
              onTap: state.login,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  // adding color will hide the splash effect
                  color: const Color(0xff153faa),
                ),
                child: const Text(
                  "Log in",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ));
  }
}
