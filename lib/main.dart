import 'package:a_check_web/firebase_options.dart';
import 'package:a_check_web/globals.dart';
import 'package:a_check_web/new_main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    try {
      print("Connecting to local Firebase emulator");
      // !!! CHANGE PORT TO THE PORT WHERE FIRESTORE IS HOSTED !!!
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    } catch (e) {
      print(e);
    }
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scaffoldMessengerKey: snackbarKey,
        theme: ThemeData(
          fontFamily: 'Inter',
          useMaterial3: false,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.lightGreen,
            primary: Colors.lightGreen,
            secondary: Colors.lightGreenAccent
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: Colors.green),
          ),
        ),
        home: const MainScreen());
  }
}
