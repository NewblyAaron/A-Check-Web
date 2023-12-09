import 'package:a_check_web/model/school.dart';
import 'package:a_check_web/pages/teacher/teacher_list_con.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../widgets/table_actions_row.dart';

class TeacherList extends StatefulWidget {
  const TeacherList(
      {super.key, required this.onListRowTap, this.searchController});

  final Function(Teacher teacher) onListRowTap;
  final SearchController? searchController;

  @override
  State<TeacherList> createState() => TeacherListState();
}

class TeacherListView extends WidgetView<TeacherList, TeacherListState> {
  const TeacherListView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return FirestoreBuilder(
      ref: teachersRef,
      builder: (context, snapshot, child) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator(color: Color(0xff153faa)));
        }

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
              onSort: (columnIndex, ascending) => state.sort(
                  (s) => s.email ?? "Z_None", columnIndex, ascending),
              size: ColumnSize.L),
          DataColumn2(
              label: const Text("Phone Number"),
              onSort: (columnIndex, ascending) => state.sort(
                  (s) => s.phoneNumber ?? "Z_None", columnIndex, ascending),
              size: ColumnSize.M),
          const DataColumn2(label: Text("Actions"), size: ColumnSize.S)
        ];

        return PaginatedDataTable2(
          columns: columns,
          source: state.rows,
          header: buildHeader(),
          actions: [
            TableActionsRow(
              onAddButtonPressed: state.openForm,
              onDeleteAllButtonPressed: state.deleteSelected,
              addTooltip: "Add new teacher",
              deleteAllTooltip: "Delete selected rows",
            ),
          ],
          rowsPerPage: 15,
          sortColumnIndex: state.sortColumnIndex,
          sortAscending: state.sortAscending,
          renderEmptyRowsInTheEnd: false,
          empty: const Center(
            child: Text("No entries found!"),
          ),
          headingCheckboxTheme: Theme.of(context).checkboxTheme,
          headingTextStyle: const TextStyle(color: Colors.black),
          headingRowColor: MaterialStateColor.resolveWith((states) {return const Color(0xffFAF9FE);},),
          datarowCheckboxTheme: Theme.of(context).checkboxTheme,
          checkboxAlignment: Alignment.center,
          sortArrowIcon: Icons.keyboard_arrow_up_sharp,
          onSelectAll: state.rows.selectAll,
        );
      },
    );
  }

  Container buildHeader() {
    return Container(
        height: 48,
        padding: const EdgeInsets.all(8.0),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("List of Teachers",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          ],
        ));
  }
}
