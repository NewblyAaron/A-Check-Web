import 'package:a_check_web/model/school_class.dart';
import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/pages/student/student_profile_con.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:flutter/material.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({Key? key, required this.studentId, this.studentClass})
      : super(key: key);

  final String studentId;
  final SchoolClass? studentClass;

  @override
  State<StudentProfile> createState() => StudentState();
}

class StudentView extends WidgetView<StudentProfile, StudentState> {
  const StudentView(state, {Key? key}) : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return FirestoreBuilder(
      ref: studentsRef.doc(widget.studentId),
      builder: (context, snapshot, child) {
        if (snapshot.hasData) {
          final student = snapshot.data!.data!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(student),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: [
                      buildStudentInfo(student),
                      const SizedBox(height: 24),
                      // student.guardian != null
                      //     ? buildGuardianInfo(student)
                      //     : const Text("No guardian!"),
                      widget.studentClass != null
                          ? buildClassInfo(student)
                          : buildEnrolledClasses(),
                    ],
                  )),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
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

  GestureDetector buildStudentPhoto() {
    return GestureDetector(
      child: Stack(
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.bottomRight,
        fit: StackFit.loose,
        children: [
          Container(
            height: 112,
            width: 112,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Color(0xffD7E5CA), Color(0xffF9F3CC)]),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(35.0)),
              border: Border.fromBorderSide(BorderSide()),
            ),
            // TODO: display image of student from firebase
            child: const Placeholder(),
            // child: state.student.facePhotoBytes != null
            //     ? Image.memory(state.student.facePhotoBytes!)
            //     : const Icon(Icons.person_add_alt),
          ),
          Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                  color: Colors.lightGreen,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(offset: Offset(0, 2), blurRadius: 1)]),
              child: const Icon(
                Icons.camera_alt,
                size: 20,
              )),
        ],
      ),
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

  Column buildEnrolledClasses() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Enrolled Classes",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          FutureBuilder(
            future: state.numberOfEnrolledClasses,
            builder: (context, snapshot) =>
                Text(snapshot.hasData ? "${snapshot.data!}" : "..."),
          )
        ],
      ),
      FutureBuilder(
        future: state.getEnrolledClasses(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final classes = snapshot.data!;

            if (classes.isEmpty) {
              return const Text("No enrolled classes!");
            }

            return ListView(
              shrinkWrap: true,
              children: classes
                  .map((e) => Card(
                        child: ListTile(
                          title: Text(e.name),
                          subtitle: Text(e.section),
                        ),
                      ))
                  .toList(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      )
    ]);
  }

  Widget buildGuardianInfo(Student student) {
    return const Placeholder();
    // TODO: guardian information using firebase stuff
    // return Padding(
    //   padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 30),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       const Text(
    //         "Guardian Information",
    //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //       ),
    //       Text(
    //         student.guardian.toString(),
    //         style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    //       ),
    //       TextField(
    //         enabled: false,
    //         decoration: const InputDecoration(
    //             labelText: "Contact Number", isDense: true),
    //         controller: TextEditingController(text: student.guardian?.phone),
    //       ),
    //       TextField(
    //         enabled: false,
    //         decoration:
    //             const InputDecoration(labelText: "E-mail", isDense: true),
    //         controller: TextEditingController(text: student.guardian?.email),
    //       )
    //     ],
    //   ),
    // );
  }

  Widget buildClassInfo(Student student) {
    final paleMap = student.getPALEValues(widget.studentClass!.id);
    return FutureBuilder(
      future: paleMap,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Text("Present: ${snapshot.data!['present']}"),
              Text("Absent: ${snapshot.data!['absent']}"),
              Text("Late: ${snapshot.data!['late']}"),
              Text("Excused: ${snapshot.data!['excused']}"),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
