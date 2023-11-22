import 'package:a_check_web/firebase_options.dart';
import 'package:a_check_web/splash.dart';
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
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8000);
    } catch (e) {
      print(e);
    }
  }

  runApp(MaterialApp(
      theme: ThemeData(
        fontFamily: 'Inter',
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          primary: Colors.white,
          secondary: Colors.green,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.green),
        ),
      ),
      home: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      appBar: AppBar(
        elevation: 0.5,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 0),
              child: Image(
                  image: AssetImage("assets/images/logo.png"), height: 55),
            ),
            Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  const Column(
                    children: [
                      Text(
                        "De La Cruz, John",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Ateneo De Naga University",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  IconButton(
                    //TODO: DropdownMenu (if logged in) with items[View Profile, Settings, Logout] or (if not logged in) items[Sign In, Register]
                    color: Colors.black,
                    icon: const Icon(Icons.arrow_drop_down, size: 25),
                    tooltip: 'Profile',
                    onPressed: () {},
                  ),
                ]),
          ],
        ),
      ),
      body: const Splash(),
    );
  }
}
