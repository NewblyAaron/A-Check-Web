import 'package:a_check_web/forms/teacher_form.dart';
import 'package:a_check_web/globals.dart';
import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/pages/teacher/teacher_list.dart';
import 'package:a_check_web/utils/dialogs.dart';
import 'package:flutter/material.dart';

class TeacherListState extends State<TeacherList> {
  @override
  Widget build(BuildContext context) => TeacherListView(this);

  @override
  void initState() {
    super.initState();

    rows = TeacherDataSource(data: [], onViewButtonPressed: viewTeacher);

    teachersRef.snapshots().listen((event) {
      rows.updateData(event.docs.map((e) => e.data).toList());
    });
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
      this.onViewButtonPressed,
      this.onEditButtonPressed}) {
    updateData(data);
  }

  late Map<Teacher, bool> _map;
  List<Teacher> _data = [];
  final Function(Teacher student)? onViewButtonPressed;
  final Function(Teacher student)? onEditButtonPressed;

  List<Teacher> get selectedData {
    List<Teacher> selectedRows = [
      for (var s in _map.entries)
        if (s.value == true) s.key
    ];

    return selectedRows;
  }

  selectAll(bool value) {
    notifyListeners();
  }

  updateData(List<Teacher> data) {
    _data = data;
    _map = {for (var student in _data) student: _map[student] ?? false};

    notifyListeners();
  }

  void sort<T>(Comparable<T> Function(Teacher s) getField, bool ascending) {
    _data.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    return DataRow(
        cells: [
          DataCell(Text(_data[index].id)),
          DataCell(Text(_data[index].lastName)),
          DataCell(Text(_data[index].firstName)),
          DataCell(Text(_data[index].email ?? "None")),
          DataCell(Text(_data[index].phoneNumber ?? "None")),
          DataCell(
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (onViewButtonPressed is Function) {
                      onViewButtonPressed!(_data[index]);
                    }
                  },
                  icon: const Icon(Icons.visibility),
                ),
                IconButton(
                  onPressed: () {
                    if (onEditButtonPressed is Function) {
                      onEditButtonPressed!(_data[index]);
                    }
                  },
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
          ),
        ],
        selected: _map[_data[index]] ?? false,
        onSelectChanged: (value) {
          _map[_data[index]] = value ?? false;
          notifyListeners();
        });
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount =>
      _map.values.where((element) => element == true).length;
}
