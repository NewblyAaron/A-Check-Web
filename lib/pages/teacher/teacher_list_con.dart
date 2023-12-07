import 'package:a_check_web/forms/teacher_form.dart';
import 'package:a_check_web/globals.dart';
import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/pages/teacher/teacher_list.dart';
import 'package:a_check_web/utils/dialogs.dart';
import 'package:flutter/material.dart';

import '../../widgets/cell_actions.dart';

class TeacherListState extends State<TeacherList> {
  @override
  Widget build(BuildContext context) => TeacherListView(this);

  @override
  void initState() {
    super.initState();

    rows = TeacherDataSource(
        data: [],
        onViewButtonPressed: viewTeacher,
        onEditButtonPressed: (t) => openForm(teacher: t));

    teachersRef.snapshots().listen((event) {
      rows.updateData(event.docs.map((e) => e.data).toList());
    });

    widget.searchController?.addListener(filter);
  }

  @override
  void dispose() {
    super.dispose();

    widget.searchController?.removeListener(filter);
  }

  late final TeacherDataSource rows;
  int sortColumnIndex = 0;
  bool sortAscending = false;

  openForm({Teacher? teacher}) async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: TeacherForm(
          teacher: teacher,
        ),
      ),
    );
  }

  viewTeacher(Teacher teacher) {
    widget.onListRowTap(teacher);
  }

  filter() {
    setState(() => rows.filter(widget.searchController!.text));
  }

  sort<T>(Comparable<T> Function(Teacher s) getField, int columnIndex,
      bool ascending) {
    rows.sort<T>(getField, ascending);

    setState(() {
      sortColumnIndex = columnIndex;
      sortAscending = ascending;
    });
  }

  void deleteStudents() async {
    int count = rows.selectedRowCount;
    if (count == 0) {
      snackbarKey.currentState!.showSnackBar(
          const SnackBar(content: Text("You do not have any rows checked!")));
      return;
    }

    List<Teacher> teachers = rows.selectedData;
    final result = await Dialogs.showConfirmDialog(
        context,
        Text(
            "Deleting ${count == rows.rowCount ? "ALL" : count} teacher${count > 1 ? 's' : ''}"),
        Text(
            "Are you sure you want to delete $count teacher${count > 1 ? 's' : ''}?"));
    if (result == true) {
      for (var teacher in teachers) {
        await teachersRef.doc(teacher.id).delete();
      }

      snackbarKey.currentState!
          .showSnackBar(SnackBar(content: Text("Deleted $count teachers")));
    }
  }
}

class TeacherDataSource extends DataTableSource {
  TeacherDataSource(
      {required List<Teacher> data,
      required this.onViewButtonPressed,
      required this.onEditButtonPressed}) {
    updateData(data);
  }

  final Function(Teacher student) onViewButtonPressed;
  final Function(Teacher student) onEditButtonPressed;

  late Map<Teacher, bool> _map;
  List<Teacher> _data = [];
  List<Teacher> _filteredData = [];
  bool _filtered = false;

  List<Teacher> get selectedData {
    List<Teacher> selectedRows = [
      for (var s in _map.entries)
        if (s.value == true) s.key
    ];

    return selectedRows;
  }

  selectAll(bool? value) {
    _map.updateAll((_, v) => v = value ?? false);
    notifyListeners();
  }

  updateData(List<Teacher> data) {
    _data = data;
    _map = {for (var student in _data) student: _map[student] ?? false};

    notifyListeners();
  }

  void sort<T>(Comparable<T> Function(Teacher s) getField, bool ascending) {
    var data = _filtered ? _filteredData : _data;

    data.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }

  void filter<T>(String contains) {
    _filteredData = List.empty(growable: true);
    String filter = contains.toLowerCase().trim();
    if (filter.isEmpty) {
      _filtered = false;
      updateData(_data);
      return;
    }

    _filtered = true;
    for (var s in _data) {
      if (s.fullName.toLowerCase().contains(filter) ||
          s.id.toLowerCase().contains(filter)) {
        _filteredData.add(s);
      }
    }

    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    var data = _filtered ? _filteredData : _data;

    return DataRow(
        cells: [
          DataCell(Text(
            data[index].id,
            style: const TextStyle(fontSize: 12),
          )),
          DataCell(
            Text(data[index].lastName, style: const TextStyle(fontSize: 12)),
          ),
          DataCell(Text(data[index].firstName,
              style: const TextStyle(fontSize: 12))),
          DataCell(Text(data[index].email ?? "None",
              style: const TextStyle(fontSize: 12))),
          DataCell(Text(data[index].phoneNumber ?? "None",
              style: const TextStyle(fontSize: 12))),
          DataCell(
            CellActions(
              data: data[index],
              onViewButtonPressed: (o) => onViewButtonPressed(o),
              onEditButtonPressed: (o) => onEditButtonPressed(o),
              viewTooltip: "View teacher info",
              editTooltip: "Edit teacher info",
            ),
          ),
        ],
        selected: _map[data[index]] ?? false,
        onSelectChanged: (value) {
          _map[data[index]] = value ?? false;
          notifyListeners();
        });
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _filtered ? _filteredData.length : _data.length;

  @override
  int get selectedRowCount =>
      _map.values.where((element) => element == true).length;
}
