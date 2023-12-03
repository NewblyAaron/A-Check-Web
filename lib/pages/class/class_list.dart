import 'package:a_check_web/model/school_class.dart';
import 'package:a_check_web/pages/class/class_list_con.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:a_check_web/widgets/list_row.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:flutter/material.dart';

class ClassList extends StatefulWidget {
  const ClassList({super.key, required this.onListRowTap});

  final Function(SchoolClass schoolClass) onListRowTap;

  @override
  State<ClassList> createState() => ClassListState();
}
class ClassListView extends WidgetView<ClassList, ClassListState> {
  const ClassListView(super.state, {super.key});

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
                  "List of Classes",
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
                  label: const Text("Add a class"), //label text
                  style:
                  ElevatedButton.styleFrom(
                      foregroundColor: Colors.green,
                      backgroundColor: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(50, 20, 70, 0),
            child: FirestoreBuilder(
              ref: classesRef,
              builder: (context, snapshot, child) {
                if (snapshot.hasData) {
                  final classes =
                  snapshot.data!.docs.map((doc) => doc.data).toList();

                  return ListView(
                    shrinkWrap: true,
                    children: classes
                        .map((schoolClass) => GestureDetector(
                      onTap: () => state.onListRowTap(schoolClass),
                      child: ListRow(
                        object: schoolClass,
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
          // Container(
          //   margin: const EdgeInsets.fromLTRB(50, 20, 70, 0),
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     itemCount: 3,
          //     itemBuilder: (context, index) {
          //       return Card(
          //         child: ListTile(
          //           leading: const Icon(
          //             Icons.account_circle_rounded,
          //             size: 40,
          //           ),
          //           dense: false,
          //           contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
          //           selectedTileColor: Colors.blue.shade100,
          //           title: const Text("Class 1"),
          //           subtitle: const Text('ITMC'),
          //           trailing: Row(
          //               mainAxisSize: MainAxisSize.min,
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: <Widget>[
          //                 IconButton(
          //                   hoverColor: Colors.green.withOpacity(0.3),
          //                   icon: const Icon(Icons.edit_note_rounded, size: 30),
          //                   tooltip: 'Edit',
          //                   onPressed: () {},
          //                 ),
          //                 const SizedBox(width: 40),
          //                 IconButton(
          //                   highlightColor: Colors.red.withOpacity(0.3),
          //                   icon: const Icon(Icons.delete_outline, size: 30),
          //                   tooltip: 'Delete',
          //                   onPressed: () {},
          //                 ),
          //               ]),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
    );
  }
}
