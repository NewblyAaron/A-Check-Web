import 'package:a_check_web/globals.dart';
import 'package:a_check_web/model/school.dart';
import 'package:a_check_web/pages/teacher/teacher_list_con.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class TeacherCSV extends StatefulWidget {
  const TeacherCSV({Key? key, required this.teachers}) : super(key: key);

  final List<Teacher> teachers;

  @override
  State<TeacherCSV> createState() => TeacherCSVState();
}

class TeacherCSVState extends State<TeacherCSV> {
  @override
  Widget build(BuildContext context) => TeacherCSVView(this);

  @override
  void initState() {
    super.initState();

    dataSource = TeacherDataSource(data: widget.teachers, selectable: false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  late TeacherDataSource dataSource;
  int sortColumnIndex = 0;
  bool sortAscending = false;

  sort<T>(Comparable<T> Function(Teacher r) getField, int columnIndex,
      bool ascending) {
    dataSource.sort<T>(getField, ascending);

    setState(() {
      sortColumnIndex = columnIndex;
      sortAscending = ascending;
    });
  }

  void close() {
    Navigator.pop(context);
  }

  void finalize() async {
    for (var t in widget.teachers) {
      await teachersRef.doc(t.id).set(t);
    }

    if (mounted) {
      snackbarKey.currentState!.showSnackBar(const SnackBar(
          content: Text("Successfully imported the .csv file!")));
      Navigator.pop(context);
    }
  }
}

class TeacherCSVView extends WidgetView<TeacherCSV, TeacherCSVState> {
  const TeacherCSVView(state, {Key? key}) : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    List<DataColumn2> columns = [
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
      DataColumn2(
          label: const Text("E-mail"),
          onSort: (columnIndex, ascending) =>
              state.sort((s) => s.email ?? "Z_None", columnIndex, ascending),
          size: ColumnSize.L),
      DataColumn2(
          label: const Text("Phone Number"),
          onSort: (columnIndex, ascending) => state.sort(
              (s) => s.phoneNumber ?? "Z_None", columnIndex, ascending),
          size: ColumnSize.M)
    ];

    return SizedBox(
      width: 800,
      height: 800,
      child: Stack(children: [
        PaginatedDataTable2(
          columns: columns,
          source: state.dataSource,
          rowsPerPage: 15,
          sortColumnIndex: state.sortColumnIndex,
          sortAscending: state.sortAscending,
          renderEmptyRowsInTheEnd: false,
          empty: const Center(
            child: Text("No entries found!"),
          ),
          headingCheckboxTheme: Theme.of(context).checkboxTheme,
          headingTextStyle: const TextStyle(color: Colors.black),
          headingRowColor: MaterialStateColor.resolveWith(
            (states) {
              return const Color(0xffFAF9FE);
            },
          ),
          datarowCheckboxTheme: Theme.of(context).checkboxTheme,
          checkboxAlignment: Alignment.center,
          sortArrowIcon: Icons.keyboard_arrow_up_sharp,
          onSelectAll: state.dataSource.selectAll,
        ),
        Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.only(bottom: 72, right: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Passwords are '123' by default"),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: state.finalize,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.check),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: state.close,
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.close),
                ),
              ],
            )),
      ]),
    );
  }
}
