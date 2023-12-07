import 'package:a_check_web/model/attendance_record.dart';
import 'package:a_check_web/pages/class/attendance_records/attendance_records_con.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class AttendanceRecordsPage extends StatefulWidget {
  const AttendanceRecordsPage({Key? key, required this.records})
      : super(key: key);

  final List<AttendanceRecord> records;

  @override
  State<AttendanceRecordsPage> createState() => AttendanceRecordsState();
}

class AttendanceRecordsView
    extends WidgetView<AttendanceRecordsPage, AttendanceRecordsState> {
  const AttendanceRecordsView(state, {Key? key}) : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 800,
      height: 800,
      child: Stack(children: [
        DataTable2(
            isHorizontalScrollBarVisible: true,
            sortColumnIndex: state.sortColumnIndex,
            sortAscending: state.sortAscending,
            columns: [
              DataColumn2(
                label: const Text("Last Name"),
                onSort: (columnIndex, ascending) =>
                    state.sort((r) => r.studentId, columnIndex, ascending),
              ),
              DataColumn2(
                label: const Text("First Name"),
                onSort: (columnIndex, ascending) =>
                    state.sort((r) => r.studentId, columnIndex, ascending),
              ),
              DataColumn2(
                label: const Text("Time"),
                onSort: (columnIndex, ascending) =>
                    state.sort((r) => r.dateTime, columnIndex, ascending),
              ),
              DataColumn2(
                label: const Text("Status"),
                onSort: (columnIndex, ascending) =>
                    state.sort((r) => r.status.index, columnIndex, ascending),
              )
            ],
            rows: List<DataRow2>.generate(state.dataSource.rowCount,
                (index) => state.dataSource.getRow(index)!)),
        Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.only(bottom: 16, right: 16),
            child: FloatingActionButton(
              onPressed: state.close,
              child: const Icon(Icons.close),
            ))
      ]),
    );
  }
}
