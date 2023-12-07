import 'package:a_check_web/model/attendance_record.dart';
import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/pages/class/attendance_records/attendance_records_page.dart';
import 'package:a_check_web/utils/dialogs.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceRecordsState extends State<AttendanceRecordsPage> {
  @override
  Widget build(BuildContext context) => AttendanceRecordsView(this);

  @override
  void initState() {
    super.initState();

    dataSource = AttendanceRecordDataSource(data: widget.records);
  }

  late AttendanceRecordDataSource dataSource;
  int sortColumnIndex = 0;
  bool sortAscending = false;

  sort<T>(Comparable<T> Function(AttendanceRecord r) getField, int columnIndex,
      bool ascending) {
    dataSource.sort<T>(getField, ascending,
        byFirstName: columnIndex == 0, byLastName: columnIndex == 1);

    setState(() {
      sortColumnIndex = columnIndex;
      sortAscending = ascending;
    });
  }

  void deleteRecord() async {
    final result = await Dialogs.showConfirmDialog(
        context,
        const Text("Delete Record"),
        const Text("This action will delete this record. Continue?"));
    if (result != null && result) {
      final ids = widget.records.map((e) => e.id);
      for (var id in ids) {
        await attendancesRef.doc(id).delete();
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Deleted the record.")));
        Navigator.pop(context);
      }
    }
  }

  void close() {
    Navigator.pop(context);
  }
}

class AttendanceRecordDataSource extends DataTableSource {
  AttendanceRecordDataSource({
    required List<AttendanceRecord> data,
  }) {
    updateData(data);
  }

  List<AttendanceRecord> _data = [];
  Map<String, Student> _studentMap = {};

  updateData(List<AttendanceRecord> data) async {
    _data = data;
    _studentMap = {for (var e in data) e.studentId: await e.student};

    notifyListeners();
  }

  void sort<T>(
      Comparable<T> Function(AttendanceRecord s) getField, bool ascending,
      {bool? byLastName, bool? byFirstName}) {
    _data.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);

      if (byLastName ?? false) {
        return ascending
            ? Comparable.compare(
                _studentMap[aValue]!.lastName, _studentMap[bValue]!.lastName)
            : Comparable.compare(
                _studentMap[bValue]!.lastName, _studentMap[aValue]!.lastName);
      } else if (byFirstName ?? false) {
        return ascending
            ? Comparable.compare(
                _studentMap[aValue]!.firstName, _studentMap[bValue]!.firstName)
            : Comparable.compare(
                _studentMap[bValue]!.firstName, _studentMap[aValue]!.firstName);
      }

      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }

  @override
  DataRow2? getRow(int index) {
    return DataRow2(cells: [
      DataCell(FutureBuilder(
        future: _data[index].student,
        builder: (context, snapshot) => Text(snapshot.data?.lastName ?? "",
            style: const TextStyle(fontSize: 12)),
      )),
      DataCell(FutureBuilder(
        future: _data[index].student,
        builder: (context, snapshot) => Text(snapshot.data?.firstName ?? "",
            style: const TextStyle(fontSize: 12)),
      )),
      DataCell(Text(
          DateFormat(DateFormat.HOUR_MINUTE).format(_data[index].dateTime),
          style: const TextStyle(fontSize: 12))),
      DataCell(Text(_data[index].status.name)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
