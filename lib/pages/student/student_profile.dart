import 'package:a_check_web/model/school.dart';
import 'package:a_check_web/pages/student/student_profile_con.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:flutter/material.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({Key? key, required this.student}) : super(key: key);

  final Student student;

  @override
  State<StudentProfile> createState() => StudentState();
}

class StudentView extends WidgetView<StudentProfile, StudentState> {
  const StudentView(state, {Key? key}) : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeader(state.student),
        SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  buildStudentInfo(state.student),
                  const SizedBox(height: 24),
                  if (state.student.guardian != null)
                    buildGuardianInfo(state.student),
                  buildEnrolledClasses()
                ],
              )),
        ),
      ],
    );
  }

  Widget buildHeader(Student student) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildStudentPhoto(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        student.fullName.toString(),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        student.id,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStudentPhoto() {
    return Stack(
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.bottomRight,
      fit: StackFit.loose,
      children: [
        Container(
            height: 250,
            width: 250,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(35.0)),
              border: Border.fromBorderSide(
                  BorderSide(strokeAlign: BorderSide.strokeAlignOutside)),
            ),
            child: FutureBuilder(
                future: state.student.getPhotoUrl(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return snapshot.hasData
                        ? snapshot.data!.isNotEmpty
                            ? Image.network(
                                snapshot.data!,
                                fit: BoxFit.cover,
                              )
                            : const Center(
                                child: Icon(
                                  Icons.person_outline,
                                  size: 64,
                                ),
                              )
                        : const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })),
        GestureDetector(
          onTap: state.pickPhoto,
          child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                  color: Color(0xFF153FAA),
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(offset: Offset(0, 2), blurRadius: 1)]),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 20,
              )),
        ),
      ],
    );
  }

  Widget buildStudentInfo(Student student) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Student Information",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              title: Text(student.email!),
              leading: const Icon(Icons.email),
            ),
            ListTile(
              title: Text(student.phoneNumber!),
              leading: const Icon(Icons.phone),
            ),
          ],
        )
      ],
    );
  }

  Widget buildEnrolledClasses() {
    return StreamBuilder(
        stream: state.getEnrolledClasses(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final classes = snapshot.data!.docs.map((e) => e.data).toList();

          if (classes.isEmpty) {
            return const Text("No enrolled classes!");
          }

          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Enrolled Classes",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(snapshot.hasData
                        ? "${snapshot.data!.docs.length}"
                        : "..."),
                  ],
                ),
                ListView(
                  shrinkWrap: true,
                  children: classes
                      .map((e) => Card(
                            child: ListTile(
                              title: Text(e.name),
                              subtitle: Text(e.section),
                            ),
                          ))
                      .toList(),
                ),
              ]);
        });
  }

  Widget buildGuardianInfo(Student student) {
    if (student.guardian == null) {
      return const Center(
        child: Text("No guardian!"),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Guardian Information",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ListTile(
          title: Text(student.guardian!.email ?? "None"),
          leading: const Icon(Icons.email),
        ),
        ListTile(
          title: Text(student.guardian!.phoneNumber!),
          leading: const Icon(Icons.phone),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
