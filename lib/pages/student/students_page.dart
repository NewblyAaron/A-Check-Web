import 'package:a_check_web/pages/student/student_list.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:flutter/material.dart';
import './students_page_con.dart';

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
        body: Row(
      children: [
        Flexible(
          flex: 2,
          child: StudentList(
            onListRowTap: state.onListRowTap,
          ),
        ),
        const VerticalDivider(
          color: Colors.black,
          thickness: 0.1,
        ),
        Flexible(
          flex: 1,
          child: state.studentProfile ??
              Container(
                  alignment: Alignment.center,
                  child: const Text('Select a student to show profile.')),
        ),
      ],
    ));
  }
}
