import 'package:a_check_web/pages/class/class_list.dart';
import 'package:a_check_web/pages/class/classes_page_con.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:flutter/material.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({super.key, this.searchController});

  final SearchController? searchController;

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
            searchController: widget.searchController,
          ),
        ),
        const VerticalDivider(
          color: Colors.black,
          thickness: 0.1,
        ),
        state.classProfileWidget != null
            ? Flexible(
                flex: 1,
                child: Stack(children: [
                  state.classProfileWidget!,
                  Container(
                    padding: const EdgeInsets.only(top: 16, right: 16),
                    alignment: Alignment.topRight,
                    child: IconButton(
                        splashRadius: 15,
                        color: const Color(0xff153faa),
                        onPressed: state.closeProfile,
                        icon: const Icon(Icons.close)),
                  )
                ]))
            : Container(),
      ],
    );
  }
}
