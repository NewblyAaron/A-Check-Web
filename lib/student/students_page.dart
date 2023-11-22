import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/student/students_page_con.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:a_check_web/widgets/list_row.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:a_check_web/forms/student_form_page.dart';
import 'package:flutter/material.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => StudentsPageState();
}

class StudentsPageView extends WidgetView<StudentsPage, StudentsPageState> {
  const StudentsPageView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 70, 70, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  "List of Students",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 25,
                    color: Color(0xff000000),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentFormPage()),
                    );
                  },
                  icon: const Icon(
                      Icons.group_add_rounded), //icon data for elevated button
                  label: const Text("Add a student"), //label text
                  style:
                      ElevatedButton.styleFrom(foregroundColor: Colors.green),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(50, 20, 70, 0),
            child: FirestoreBuilder(
              ref: studentsRef,
              builder: (context, snapshot, child) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final students =
                    snapshot.data!.docs.map((doc) => doc.data).toList();

                return ListView(
                  shrinkWrap: true,
                  children: students
                      .map((student) => ListRow(
                            object: student,
                          ))
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
