import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

bool bypassLogin = false;
  
final storage = FirebaseStorage.instance;