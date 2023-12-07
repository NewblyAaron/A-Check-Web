import 'package:a_check_web/auth.dart';
import 'package:a_check_web/firebase_options.dart';
import 'package:a_check_web/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

  if (kDebugMode) {
    try {
      print("Connecting to local Firebase emulator");
      // !!! CHANGE PORT TO THE PORT WHERE FIRESTORE IS HOSTED !!!
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
      await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    } catch (e) {
      print(e);
    }
  }

  runApp(MaterialApp(
      scaffoldMessengerKey: snackbarKey,
      theme: ThemeData(
        fontFamily: 'Inter',
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff153faa),
          secondary: Colors.transparent,
        ),
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: const Color(0xff353535)),
        ),
      ),
      home: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Color(0xff000000), body: AuthGate());
  }
}
