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
        // func.httpsCallable("addAdminRole").call({
        //   "email": value.user!.email,
        //   "schoolId": ref.id,
        // }).then((value) {
        //   if (!value.data) {
        //     throw FirebaseAuthException(code: 'set-admin-fail');
        //   }

        //   ref.set(school).whenComplete(() {
        //     snackbarKey.currentState!
        //         .showSnackBar(const SnackBar(content: Text("Registered!")));
        //     Navigator.pop(context);
        //   });
        // });
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
      body: buildBody(context),
    );
  }

  Widget buildBody(context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: SingleChildScrollView(
          child: Card(
            color: Colors.white,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SizedBox(
                width: 350,
                height: 800,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                            height: 800,
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
                                  "Register a School",
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
                                      height: 25,
                                    ),
                                    InkWell(
                                      customBorder: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      // hoverColor: const Color(0xff153faa).withOpacity(0.8),
                                      // highlightColor: const Color(0xff153faa).withOpacity(0.4),
                                      // splashColor: const Color(0xff153faa).withOpacity(1),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
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
                                              Icons.keyboard_backspace_rounded,
                                              color: Color(0xff153faa),
                                              size: 23,
                                            ),
                                            SizedBox(
                                              width: 9,
                                            ),
                                            Text(
                                              "Back to Login",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff153faa)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
              controller: state.schoolNameCon,
              validator: Validators.hasValue,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.school_rounded,
                    color: Colors.black54,
                    size: 20,
                  ),
                  labelText: "School Name"),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: state.officeNameCon,
              validator: Validators.hasValue,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.co_present_rounded,
                    color: Colors.black54,
                    size: 20,
                  ),
                  labelText: "Office Name"),
            ),
            const SizedBox(height: 12),
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
                  labelText: "E-mail"),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: state.passwordCon,
              validator: Validators.hasValue,
              obscureText: true,
              obscuringCharacter: '•',
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.key_rounded,
                    color: Colors.black54,
                    size: 20,
                  ),
                  labelText: "Password"),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: state.confirmCon,
              validator: state.confirmPassword,
              onFieldSubmitted: (_) => state.register(),
              obscureText: true,
              obscuringCharacter: '•',
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.password_rounded,
                    color: Colors.black54,
                    size: 20,
                  ),
                  labelText: "Confirm Password"),
            ),
            const SizedBox(height: 12),
            InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              // hoverColor: const Color(0xff153faa).withOpacity(0.8),
              // highlightColor: const Color(0xff153faa).withOpacity(0.4),
              // splashColor: const Color(0xff153faa).withOpacity(1),
              onTap: state.register,
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
                  "Register",
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
