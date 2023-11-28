import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/pages/teacher/teacher_list_con.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:a_check_web/widgets/list_row.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:flutter/material.dart';

class TeacherList extends StatefulWidget {
  const TeacherList({super.key, required this.onListRowTap});

  final Function(Teacher teacher) onListRowTap;

  @override
  State<TeacherList> createState() => TeacherListState();
}

class TeacherListView extends WidgetView<TeacherList, TeacherListState> {
  const TeacherListView(super.state, {super.key});

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
                "List of Teachers",
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
                icon: const Icon(
                    Icons.group_add_rounded), //icon data for elevated button
                label: const Text("Add a teacher"), //label text
                style: ElevatedButton.styleFrom(foregroundColor: Colors.green),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(50, 20, 70, 0),
          child: FirestoreBuilder(
            ref: teachersRef,
            builder: (context, snapshot, child) {
              if (snapshot.hasData) {
                final teachers =
                    snapshot.data!.docs.map((doc) => doc.data).toList();

                return ListView(
                  shrinkWrap: true,
                  children: teachers
                      .map((teacher) => GestureDetector(
                        onTap: () => state.onListRowTap(teacher),
                        child: ListRow(
                              object: teacher,
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
