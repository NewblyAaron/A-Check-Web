import 'package:a_check_web/forms/student_form.dart';
import 'package:a_check_web/globals.dart';
import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/pages/student/student_list.dart';
import 'package:a_check_web/utils/dialogs.dart';
import 'package:a_check_web/widgets/cell_actions.dart';
import 'package:flutter/material.dart';

class StudentListState extends State<StudentList> {
  @override
  Widget build(BuildContext context) => StudentListView(this);

  @override
  void initState() {
    super.initState();

    rows = StudentDataSource(
        data: [],
        onViewButtonPressed: viewStudent,
        onEditButtonPressed: (s) => openForm(student: s));

    studentsRef.snapshots().listen((event) {
      setState(() => rows.updateData(event.docs.map((e) => e.data).toList()));
    });

    widget.searchController?.addListener(filter);
  }

  @override
  void dispose() {
    super.dispose();

    widget.searchController?.removeListener(filter);
  }

  late final StudentDataSource rows;
  int sortColumnIndex = 0;
  bool sortAscending = false;

  filter() {
    setState(() => rows.filter(widget.searchController!.text));
  }

  sort<T>(Comparable<T> Function(Student s) getField, int columnIndex,
      bool ascending) {
    rows.sort<T>(getField, ascending);

    setState(() {
      sortColumnIndex = columnIndex;
      sortAscending = ascending;
    });
  }

  openForm({Student? student}) async {
    if (context.mounted) {
      await showDialog(
        context: context,
        builder: (context) => Dialog(
          child: StudentForm(
            student: student,
          ),
        ),
      );
    }
  }

  viewStudent(Student student) async {
    widget.onRowTap(student);
  }

  deleteStudents() async {
    int count = rows.selectedRowCount;
    if (count == 0) {
      snackbarKey.currentState!.showSnackBar(
          const SnackBar(content: Text("You do not have any rows checked!")));
      return;
    }

    List<Student> students = rows.selectedData;
    final result = await Dialogs.showConfirmDialog(
        context,
        Text(
            "Deleting ${count == rows.rowCount ? "ALL" : count} student${count > 1 ? 's' : ''}"),
        Text(
            "Are you sure you want to delete $count student${count > 1 ? 's' : ''}?"));
    if (result == true) {
      for (var student in students) {
        await studentsRef.doc(student.id).delete();
      }

      snackbarKey.currentState!
          .showSnackBar(SnackBar(content: Text("Deleted $count students")));
    }
  }
}

class StudentDataSource extends DataTableSource {
  StudentDataSource(
      {required List<Student> data,
      required this.onViewButtonPressed,
      required this.onEditButtonPressed}) {
    updateData(data);
  }

  final Function(Student student) onViewButtonPressed;
  final Function(Student student) onEditButtonPressed;

  late Map<Student, bool> _map;
  List<Student> _data = [];
  List<Student> _filteredData = [];
  bool _filtered = false;

  List<Student> get selectedData {
    List<Student> selectedRows = [
      for (var s in _map.entries)
        if (s.value == true) s.key
    ];

    return selectedRows;
  }

  selectAll(bool? value) {
    _map.updateAll((_, v) => v = value ?? false);
    notifyListeners();
  }

  updateData(List<Student> data) {
    _data = data;
    _map = {for (var student in _data) student: _map[student] ?? false};

    notifyListeners();
  }

  void sort<T>(Comparable<T> Function(Student s) getField, bool ascending) {
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
          DataCell(Text(
            data[index].lastName,
            style: const TextStyle(fontSize: 12),
          )),
          DataCell(Text(
            data[index].firstName,
            style: const TextStyle(fontSize: 12),
          )),
          DataCell(Text(
            data[index].email ?? "None",
            style: const TextStyle(fontSize: 12),
          )),
          DataCell(Text(
            data[index].phoneNumber ?? "None",
            style: const TextStyle(fontSize: 12),
          )),
          DataCell(
            CellActions(
              data: data[index],
              onViewButtonPressed: (o) => onViewButtonPressed(o),
              onEditButtonPressed: (o) => onEditButtonPressed(o),
              viewTooltip: "View student info",
              editTooltip: "Edit student info",
            ),
          )
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
