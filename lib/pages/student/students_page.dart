import 'package:a_check_web/pages/student/student_list.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:flutter/material.dart';
import './students_page_con.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key, this.searchController});

  final SearchController? searchController;

  @override
  State<StudentsPage> createState() => StudentsPageState();
}

class StudentsPageView extends WidgetView<StudentsPage, StudentsPageState> {
  const StudentsPageView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: StudentList(
            onRowTap: state.onListRowTap,
            searchController: widget.searchController,
          ),
        ),
        const VerticalDivider(
          color: Colors.black,
          thickness: 0.1,
        ),
        state.studentProfileWidget != null
            ? Flexible(
                flex: 1,
                child: Stack(children: [
                  state.studentProfileWidget!,
                  Container(
                    padding: const EdgeInsets.only(top: 16, right: 16),
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: state.closeProfile,
                        icon: const Icon(Icons.close)),
                  )
                ]))
            : Container(),
      ],
    );
  }
}
