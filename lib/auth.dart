import 'package:a_check_web/model/school.dart';
import 'package:a_check_web/new_main_screen.dart';
import 'package:a_check_web/pages/auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:flutter/material.dart';

class Auth {
  static FirebaseAuth get auth => FirebaseAuth.instance;

  static User? get currentUser => auth.currentUser;

  static Future<IdTokenResult>? get idTokenResult =>
      currentUser?.getIdTokenResult(true);
}

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

class SchoolWidget extends InheritedWidget {
  const SchoolWidget({super.key, required super.child, required this.school});

  final School school;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static SchoolWidget? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SchoolWidget>();
}
