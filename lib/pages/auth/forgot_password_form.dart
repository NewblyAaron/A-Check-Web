import 'package:a_check_web/globals.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:a_check_web/utils/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
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
      ),
    );
  }

  Form buildForm() {
    return Form(
      key: const Key(""),
      child: Padding(
        padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
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
              padding: EdgeInsets.only(bottom: 32),
              child: Text("Enter your email address. You will receive a link to create a new password via email.",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.black54,
                  )),
            ),
            TextFormField(
              controller: null,
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
          ],
        ),
      ),
    );
  }

  Row buildButtons() {
    return Row(
      children: [
        Column(
          children: [
            InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              // hoverColor: const Color(0xff153faa).withOpacity(0.8),
              // highlightColor: const Color(0xff153faa).withOpacity(0.4),
              // splashColor: const Color(0xff153faa).withOpacity(1),
              onTap: null,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  // adding color will hide the splash effect
                  color: const Color(0xff153faa),
                ),
                child: const Text(
                  "Request Reset Link",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const MaterialButton(
                minWidth: 30,
                onPressed: null,
                hoverColor: Colors.transparent,
                child: Text(
                  "Go back to Login",
                  style: TextStyle(
                      color: Color(0xff153faa),
                      fontWeight: FontWeight.w500,
                      decoration:
                      TextDecoration.underline),
                )),
          ],
        ),
      ],
    );
  }
}
