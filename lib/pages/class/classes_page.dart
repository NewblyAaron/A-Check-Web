import 'package:a_check_web/pages/class/class_list.dart';
import 'package:a_check_web/pages/class/classes_page_con.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:flutter/material.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({super.key});

  @override
  State<ClassesPage> createState() => ClassesPageState();
}

class ClassesPageView extends WidgetView<ClassesPage, ClassesPageState> {
  const ClassesPageView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: ClassList(
            onListRowTap: state.onListRowTap,
          ),
        ),
        const VerticalDivider(
          color: Colors.black,
          thickness: 0.1,
        ),
        Flexible(
          flex: 1,
          child: state.classProfile ??
              Container(
                  alignment: Alignment.center,
                  child: const Text('Select a class to view details.')),
        ),
      ],
    );
  }
}
