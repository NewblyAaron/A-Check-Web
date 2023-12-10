import 'package:a_check_web/new_main_screen.dart';
import 'package:a_check_web/pages/auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:flutter/material.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final authStateChanges = FirebaseAuth.instance.authStateChanges();

  @override
  void initState() {
    super.initState();

    authStateChanges.listen((event) {
      event?.reload();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authStateChanges,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LoginPage();
        }

        return const MainScreen();
      },
    );
  }
}