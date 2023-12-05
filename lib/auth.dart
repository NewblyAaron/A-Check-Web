import 'package:a_check_web/new_main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
            ],
            headerBuilder: (context, constraints, shrinkOffset) => const Image(
                image: AssetImage("assets/images/logo.png"), height: 60),
            sideBuilder: (context, constraints) => const AspectRatio(
              aspectRatio: 1,
              child: Image(image: AssetImage("assets/images/logo.png")),
            ),
          );
        }

        return const MainScreen();
      },
    );
  }
}
