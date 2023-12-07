import 'package:a_check_web/globals.dart';
import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/model/school_class.dart';
import 'package:a_check_web/pages/student/student_profile.dart';
import 'package:a_check_web/utils/dialogs.dart';
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

    studentsRef.doc(widget.student.id).snapshots().listen((event) {
      if (context.mounted) setState(() => student = event.data!);
    });
  }

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

  void removeFromClass() async {
    final result = await Dialogs.showConfirmDialog(
        context,
        const Text("Warning"),
        Text(
            "${widget.student.firstName} will be removed to class ${widget.studentClass!.id}. Continue?"));
    if (result == null || !result) {
      return;
    }

    final newStudentIds = widget.studentClass!.studentIds;
    newStudentIds.remove(widget.student.id);

    classesRef
        .doc(widget.studentClass!.id)
        .update(studentIds: newStudentIds)
        .then((_) {
      Navigator.pop(context);
    });
  }
}
