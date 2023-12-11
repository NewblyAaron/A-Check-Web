import 'package:a_check_web/auth.dart';
import 'package:a_check_web/firebase_options.dart';
import 'package:a_check_web/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:google_fonts/google_fonts.dart';

late final SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

  prefs = await SharedPreferences.getInstance();
  setDefaultPrefs();

  // if (kDebugMode) {
  //   bypassLogin = false;
  //   try {
  //     print("Connecting to local Firebase emulator");
  //     // !!! CHANGE PORT TO THE PORT WHERE FIRESTORE IS HOSTED !!!
  //     await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  //     await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  //     FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
  //     FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  runApp(MaterialApp(
      scaffoldMessengerKey: snackbarKey,
      theme: ThemeData(
        fontFamily: 'Inter',
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff153faa),
            primary: const Color(0xff153faa),
            secondary: Colors.black,
            onPrimary: Colors.white,
            onSecondary: Colors.white),
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        disabledColor: const Color(0xff153faa),
        hoverColor: Colors.blueAccent.shade100.withOpacity(0.2),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: const Color(0xff353535)),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateColor.resolveWith(
            (states) {
              if (states.contains(MaterialState.selected)) {
                return const Color(
                    0xff153faa); // the color when checkbox is selected;
              }
              return Colors.white; //the color when checkbox is unselected;
            },
          ),
        ),
      ),
      home: const MainApp()));
}

void setDefaultPrefs() async {
  if (!prefs.containsKey('school_name')) {
    await prefs.setString('school_name', "School Name");
  }
  if (!prefs.containsKey('office_name')) {
    await prefs.setString('office_name', "Office Name");
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Color(0xff000000), body: AuthGate());
  }
}
