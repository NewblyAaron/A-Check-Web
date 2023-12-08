import 'package:a_check_web/globals.dart';
import 'package:a_check_web/new_main_screen.dart';
import 'package:a_check_web/pages/auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    if (bypassLogin) {
      return const MainScreen();
    }

    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LoginPage();
          // return SignInScreen(
          //   providers: [
          //     EmailAuthProvider(),
          //   ],
          //   headerBuilder: (context, constraints, shrinkOffset) => const Padding(
          //     padding: EdgeInsets.all(20.0),
          //     child: Image(
          //         image: AssetImage("assets/images/logo_blue.png"), height: 60),
          //   ),
          //   sideBuilder: (context, constraints) => const AspectRatio(
          //     aspectRatio: 1,
          //     child: Image(image: AssetImage("assets/images/logo_blue.png")),
          //   ),
          // );
        }

        return const MainScreen();
      },
    );
  }
}
