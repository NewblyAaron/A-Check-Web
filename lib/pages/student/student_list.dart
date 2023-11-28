import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/pages/student/student_list_con.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:a_check_web/widgets/list_row.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:flutter/material.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key, required this.onListRowTap});

  final Function(Student teacher) onListRowTap;

  @override
  State<StudentList> createState() => StudentListState();
}

class StudentListView extends WidgetView<StudentList, StudentListState> {
  const StudentListView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                onPressed: state.openForm,
                icon: const Icon(Icons.group_add_rounded),
                label: const Text("Add a student"),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.green,
                    backgroundColor: Colors.white
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(50, 20, 70, 0),
          child: FirestoreBuilder(
            ref: studentsRef,
            builder: (context, snapshot, child) {
              if (snapshot.hasData) {
                final students =
                    snapshot.data!.docs.map((doc) => doc.data).toList();

                return ListView(
                  shrinkWrap: true,
                  children: students
                      .map((student) => GestureDetector(
                        onTap: () => state.onListRowTap(student),
                        child: ListRow(
                              object: student,
                            ),
                      ))
                      .toList(),
                );
              } else {
                return const Text("Loading...");
              }
            },
          ),
        ),
      ],
    );
  }
}
