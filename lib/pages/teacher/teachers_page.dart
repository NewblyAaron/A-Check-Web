import 'package:a_check_web/pages/teacher/teacher_list.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:flutter/material.dart';

import './teachers_page_con.dart';

class TeachersPage extends StatefulWidget {
  const TeachersPage({super.key});

  @override
  State<TeachersPage> createState() => TeachersPageState();
}

class TeachersPageView extends WidgetView<TeachersPage, TeachersPageState> {
  const TeachersPageView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
          children: [
            Flexible(
              flex: 2,
              child: TeacherList(
                onListRowTap: state.onListRowTap,
              ),
            ),
            const VerticalDivider(
              color: Colors.black,
              thickness: 0.1,
            ),
            Flexible(
              flex: 1,
              child:
                state.teacherInfoWidget ?? Container(
                  alignment: Alignment.center,
                  child:
                    const Text('Select a teacher to show profile.')
              ),
            ),
          ],
        )
    );
  }
}
