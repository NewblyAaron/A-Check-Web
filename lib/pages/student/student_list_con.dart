import 'package:a_check_web/forms/student_form.dart';
import 'package:a_check_web/globals.dart';
import 'package:a_check_web/model/person.dart';
import 'package:a_check_web/pages/student/student_list.dart';
import 'package:a_check_web/utils/dialogs.dart';
import 'package:flutter/material.dart';

class StudentListState extends State<StudentList> {
  @override
  Widget build(BuildContext context) => StudentListView(this);

  @override
  void initState() {
    super.initState();

    rows =
        StudentDataSource(data: [], onViewButtonPressed: viewStudent);

    studentsRef.snapshots().listen((event) {
      rows.updateData(event.docs.map((e) => e.data).toList());
    });
  }

  late final StudentDataSource rows;
  int sortColumnIndex = 0;
  bool sortAscending = false;

  sort<T>(Comparable<T> Function(Student s) getField, int columnIndex,
      bool ascending) {
    rows.sort<T>(getField, ascending);

    setState(() {
      sortColumnIndex = columnIndex;
      sortAscending = ascending;
    });
  }

  openForm({String? studentId}) async {
    final Student? result = await showDialog(
      context: context,
      builder: (context) => const Dialog(
        child: StudentForm(),
      ),
    );

    if (result != null) {}
  }

  viewStudent(Student? student) async {
    widget.onRowTap(student);
  }

  deleteStudent(String studentId) {}

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
        Text("Deleting ${count == rows.rowCount ? "ALL" : count} students"),
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
  StudentDataSource({required List<Student> data, this.onViewButtonPressed}) {
    updateData(data);
  }

  late Map<Student, bool> _map;
  List<Student> _data = [];
  final Function(Student student)? onViewButtonPressed;

  List<Student> get selectedData {
    List<Student> selectedRows = [
      for (var s in _map.entries)
        if (s.value == true) s.key
    ];

    return selectedRows;
  }

  selectAll(bool value) {
    notifyListeners();
  }

  updateData(List<Student> data) {
    _data = data;
    _map = {for (var student in _data) student: _map[student] ?? false};

    notifyListeners();
  }

  void sort<T>(Comparable<T> Function(Student s) getField, bool ascending) {
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
            IconButton(
              onPressed: () {
                if (onViewButtonPressed is Function) {
                  onViewButtonPressed!(_data[index]);
                }
              },
              icon: const Icon(Icons.visibility),
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
