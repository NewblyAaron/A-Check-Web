import 'package:a_check_web/globals.dart';
import 'package:a_check_web/utils/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailCon;

  @override
  void initState() {
    super.initState();

    emailCon = TextEditingController();
  }

  void finalize() async {
    if (!formKey.currentState!.validate()) return;

    try {
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailCon.text)
          .whenComplete(() {
        snackbarKey.currentState!.showSnackBar(const SnackBar(
            content:
                Text("Please check your email for your password reset link.")));
      });
    } on FirebaseAuthException catch (ex) {
      snackbarKey.currentState!
          .showSnackBar(SnackBar(content: Text(ex.message ?? ex.code)));
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: 400,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildForm(),
          const SizedBox(
            height: 16,
          ),
          buildButtons()
        ],
      ),
    );
  }

  Form buildForm() {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 32, left: 12, right: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 32),
              child: Text("Reset Your Password",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Colors.black,
                  )),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text(
                  "Enter your email address. You will receive a link to create a new password via email.",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.black54,
                  )),
            ),
            const SizedBox(height: 12,),
            TextFormField(
              controller: emailCon,
              validator: Validators.isAnEmail,
              onFieldSubmitted: (_) => finalize(),
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
          ],
        ),
      ),
    );
  }

  Row buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0, left: 12, right: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                color: const Color(0xff153faa),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)),
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  // hoverColor: const Color(0xff153faa).withOpacity(0.8),
                  // highlightColor: const Color(0xff153faa).withOpacity(0.4),
                  // splashColor: const Color(0xff153faa).withOpacity(1),
                  onTap: finalize,
                  child: Container(
                    width:344,
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                    child: const Text(
                      "Request Reset Link",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                  padding: const EdgeInsets.only(bottom: 12),
                  minWidth: 30,
                  onPressed: () => Navigator.pop(context),
                  hoverColor: Colors.transparent,
                  child: const Text(
                    "Go back to Login",
                    style: TextStyle(
                        color: Color(0xff153faa),
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
