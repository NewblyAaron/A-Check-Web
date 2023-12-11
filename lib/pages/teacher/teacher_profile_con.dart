import 'dart:async';

import 'package:a_check_web/globals.dart';
import 'package:a_check_web/model/school.dart';

import 'package:a_check_web/pages/teacher/teacher_profile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TeacherState extends State<TeacherProfile> {
  @override
  Widget build(BuildContext context) => TeacherView(this);

  @override
  void initState() {
    super.initState();

    teacher = widget.teacher;

    teachersStream =
        teachersRef.doc(widget.teacher.id).snapshots().listen((event) {
      if (context.mounted) setState(() => teacher = event.data!);
    });
  }

  @override
  void dispose() {
    super.dispose();

    teachersStream.cancel();
  }

  late StreamSubscription teachersStream;
  final _picker = ImagePicker();
  late Teacher teacher;
  double? uploadProgress;

  pickPhoto() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      snackbarKey.currentState!
          .showSnackBar(const SnackBar(content: Text("Select a valid photo!")));
      return;
    }

    final fsRef = storage.ref().child("teacher_profiles/${image.name}");
    final uploadTask = fsRef.putData(await image.readAsBytes(),
        SettableMetadata(contentType: image.mimeType));

    uploadTask.snapshotEvents.listen((event) {
      setState(() {
        uploadProgress =
            event.bytesTransferred.toDouble() / event.totalBytes.toDouble();
      });
    });

    uploadTask.whenComplete(() {
      setState(() => uploadProgress = null);
      snackbarKey.currentState!.clearSnackBars();

      teachersRef.doc(teacher.id).update(photoPath: fsRef.fullPath).then((_) =>
          snackbarKey.currentState!.showSnackBar(SnackBar(
              content: Text("Uploaded photo of ${teacher.fullName}!"))));
    });

    snackbarKey.currentState!.showSnackBar(SnackBar(
      content: Row(
        children: [
          CircularProgressIndicator(value: uploadProgress),
          const SizedBox(width: 8),
          const Text("Uploading file...")
        ],
      ),
      action: SnackBarAction(
          label: "Cancel",
          onPressed: () {
            uploadTask.cancel();
          }),
      dismissDirection: DismissDirection.none,
      duration: const Duration(minutes: 1),
    ));
  }

  Stream<SchoolClassQuerySnapshot> getEnrolledClasses() {
    return classesRef.whereTeacherId(isEqualTo: widget.teacher.id).snapshots();
  }
}
