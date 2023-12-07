import 'package:a_check_web/forms/students_form_page.dart';
import 'package:a_check_web/model/person.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class StudentsFormState extends State<StudentsFormPage> {
  @override
  void initState() {
    super.initState();

    studentsMap = widget.studentsMap;
    dataSource = StudentDataSource(data: studentsMap);
    searchController = SearchController();

    dataSource.addListener(() => setState(() {}));
    searchController.addListener(filter);
  }

  late SearchController searchController;

  late Map<Student, bool> studentsMap;
  late StudentDataSource dataSource;
  int sortColumnIndex = 0;
  bool sortAscending = false;

  sort<T>(Comparable<T> Function(Student s) getField, int columnIndex,
      bool ascending) {
    dataSource.sort<T>(getField, ascending);

    setState(() {
      sortColumnIndex = columnIndex;
      sortAscending = ascending;
    });
  }

  filter() {
    setState(() => dataSource.filter(searchController.text));
  }

  void checkBoxOnChanged(Student key, bool? value) {
    setState(() => studentsMap[key] = value!);
  }

  void finalize() {
    List<String> selectedStudents =
        dataSource.selectedData.map((e) => e.id).toList();

    Navigator.pop(context, selectedStudents);
  }

  @override
  Widget build(BuildContext context) => StudentsFormView(this);
}

class StudentDataSource extends DataTableSource {
  StudentDataSource({required Map<Student, bool> data}) {
    updateData(data);
  }

  late Map<Student, bool> _map;
  List<Student> _data = [];
  bool _filtered = false;
  List<Student> _filteredData = [];

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

  updateData(Map<Student, bool> data) {
    _data = data.entries.map((e) => e.key).toList();
    _map = data;

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

  void filter<T>(String contains) {
    _filteredData = List.empty(growable: true);
    String filter = contains.toLowerCase().trim();
    if (filter.isEmpty) {
      _filtered = false;
      updateData(_map);
      return;
    }

    _filtered = true;
    for (var s in _data) {
      if (s.id.toLowerCase().contains(filter) ||
          s.fullName.toLowerCase().contains(filter)) {
        _filteredData.add(s);
      }
    }

    notifyListeners();
  }

  @override
  DataRow2? getRow(int index) {
    var data = _filtered ? _filteredData : _data;

    return DataRow2(
        cells: [
          DataCell(Text(
            data[index].id,
            style: const TextStyle(fontSize: 12),
          )),
          DataCell(Text(
            data[index].firstName,
            style: const TextStyle(fontSize: 12),
          )),
          DataCell(Text(
            data[index].lastName,
            style: const TextStyle(fontSize: 12),
          )),
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
