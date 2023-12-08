import 'package:a_check_web/forms/students_form_con.dart';
import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class StudentsFormPage extends StatefulWidget {
  const StudentsFormPage({Key? key, required this.studentsMap, this.toRemove})
      : super(key: key);

  final Map<Student, bool> studentsMap;
  final bool? toRemove;

  @override
  State<StudentsFormPage> createState() => StudentsFormState();
}

class StudentsFormView extends WidgetView<StudentsFormPage, StudentsFormState> {
  const StudentsFormView(state, {Key? key}) : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      height: 800,
      child: Stack(children: [
        DataTable2(
          columns: [
            DataColumn2(
                label: const Text("ID"),
                onSort: (columnIndex, ascending) =>
                    state.sort((s) => s.id, columnIndex, ascending),
                size: ColumnSize.S),
            DataColumn2(
                label: const Text("Last Name"),
                onSort: (columnIndex, ascending) =>
                    state.sort((s) => s.lastName, columnIndex, ascending),
                size: ColumnSize.L),
            DataColumn2(
                label: const Text("First Name"),
                onSort: (columnIndex, ascending) =>
                    state.sort((s) => s.firstName, columnIndex, ascending),
                size: ColumnSize.L),
          ],
          rows: List<DataRow2>.generate(state.dataSource.rowCount,
              (index) => state.dataSource.getRow(index)!),
          sortColumnIndex: state.sortColumnIndex,
          sortAscending: state.sortAscending,
          onSelectAll: state.dataSource.selectAll,
          isHorizontalScrollBarVisible: true,
        ),
        Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: 400,
                  child: SearchBar(
                    controller: state.searchController,
                    hintText: "Search here...",
                  ),
                ),
                FloatingActionButton(
                  onPressed: state.finalize,
                  child: const Icon(Icons.check),
                ),
              ],
            ))
      ]),
    );
  }
}
