import 'package:a_check_web/forms/student_form_page.dart';
import 'package:flutter/material.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
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
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.account_circle_rounded,
                      size: 40,
                    ),
                    dense: false,
                    contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                    selectedTileColor: Colors.blue.shade100,
                    title: const Text("Student A. Ko"),
                    subtitle: const Text('studentako@gmail.com'),
                    trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            hoverColor: Colors.green.withOpacity(0.3),
                            icon: const Icon(Icons.edit_note_rounded, size: 30),
                            tooltip: 'Edit',
                            onPressed: () {},
                          ),
                          const SizedBox(width: 40),
                          IconButton(
                            highlightColor: Colors.red.withOpacity(0.3),
                            icon: const Icon(Icons.delete_outline, size: 30),
                            tooltip: 'Delete',
                            onPressed: () {},
                          ),
                        ]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
