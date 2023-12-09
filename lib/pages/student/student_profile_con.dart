import 'dart:async';

import 'package:a_check_web/globals.dart';
import 'package:a_check_web/model/school.dart';

import 'package:a_check_web/pages/student/student_profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StudentState extends State<StudentProfile> {
  @override
  Widget build(BuildContext context) {
    return StudentView(this);
  }

  @override
  void initState() {
    super.initState();

    student = widget.student;

    studentsStream = studentsRef.doc(widget.student.id).snapshots().listen((event) {
      if (context.mounted) setState(() => student = event.data!);
    });
  }

  @override
  void dispose() {
    super.dispose();

    studentsStream.cancel();
  }

  late StreamSubscription studentsStream;
  late Student student;
  final _picker = ImagePicker();

  Stream<SchoolClassQuerySnapshot> getEnrolledClasses() {
    return classesRef
        .whereStudentIds(arrayContains: widget.student.id)
        .snapshots();
  }

  pickPhoto() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      snackbarKey.currentState!
          .showSnackBar(const SnackBar(content: Text("Select a valid photo!")));
      return;
    }

    final fsRef = storage.ref().child("student_profiles/${image.name}");
    fsRef.putData(await image.readAsBytes()).whenComplete(() {
      studentsRef.doc(student.id).update(photoPath: fsRef.fullPath).then(
          (value) => snackbarKey.currentState!.showSnackBar(SnackBar(
              content: Text("Uploaded photo of ${student.fullName}!"))));
    });
  }
}
