import 'package:a_check_web/globals.dart';
import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/model/school_class.dart';
import 'package:a_check_web/pages/teacher/teacher_profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TeacherState extends State<TeacherProfile> {
  @override
  Widget build(BuildContext context) => TeacherView(this);

  @override
  void initState() {
    super.initState();

    teacher = widget.teacher;

    teachersRef.doc(widget.teacher.id).snapshots().listen((event) {
      if (context.mounted) setState(() => teacher = event.data!);
    });
  }

  final _picker = ImagePicker();
  late Teacher teacher;

  pickPhoto() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      snackbarKey.currentState!
          .showSnackBar(const SnackBar(content: Text("Select a valid photo!")));
      return;
    }

    final fsRef = storage.ref().child("teacher_profiles/${image.name}");
    fsRef.putData(await image.readAsBytes()).whenComplete(() {
      teachersRef.doc(teacher.id).update(photoPath: fsRef.fullPath).then(
          (value) => snackbarKey.currentState!.showSnackBar(SnackBar(
              content: Text("Uploaded photo of ${teacher.fullName}!"))));
    });
  }

  Stream<SchoolClassQuerySnapshot> getEnrolledClasses() {
    return classesRef.whereTeacherId(isEqualTo: widget.teacher.id).snapshots();
  }
}
