import 'package:a_check_web/forms/class_form.dart';
import 'package:a_check_web/globals.dart';
import 'package:a_check_web/model/school_class.dart';

import 'package:a_check_web/pages/class/class_list.dart';
import 'package:a_check_web/utils/dialogs.dart';
import 'package:flutter/material.dart';

class ClassListState extends State<ClassList> {
  @override
  Widget build(BuildContext context) => ClassListView(this);

  @override
  void initState() {
    super.initState();

    rows = ClassDataSource(
        data: [],
        onViewButtonPressed: viewClass,
        onEditButtonPressed: (s) => openForm(schoolClass: s));

    classesRef.snapshots().listen((event) {
      rows.updateData(event.docs.map((e) => e.data).toList());
    });
  }

  late final ClassDataSource rows;
  int sortColumnIndex = 0;
  bool sortAscending = false;

  sort<T>(Comparable<T> Function(SchoolClass s) getField, int columnIndex,
      bool ascending) {
    rows.sort<T>(getField, ascending);

    setState(() {
      sortColumnIndex = columnIndex;
      sortAscending = ascending;
    });
  }

  openForm({SchoolClass? schoolClass}) async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: ClassForm(
          schoolClass: schoolClass,
        ),
      ),
    );
  }

  viewClass(SchoolClass schoolClass) {
    widget.onListRowTap(schoolClass);
  }

  void deleteClasses() async {
    int count = rows.selectedRowCount;
    if (count == 0) {
      snackbarKey.currentState!.showSnackBar(
          const SnackBar(content: Text("You do not have any rows checked!")));
      return;
    }

    List<SchoolClass> classes = rows.selectedData;
    final result = await Dialogs.showConfirmDialog(
        context,
        Text(
            "Deleting ${count == rows.rowCount ? "ALL" : count} class${count > 1 ? 'es' : ''}"),
        Text(
            "Are you sure you want to delete $count class${count > 1 ? 'es' : ''}?"));
    if (result == true) {
      for (var schoolClass in classes) {
        await classesRef.doc(schoolClass.id).delete();
      }

      snackbarKey.currentState!
          .showSnackBar(SnackBar(content: Text("Deleted $count classes")));
    }
  }
}

class ClassDataSource extends DataTableSource {
  ClassDataSource(
      {required List<SchoolClass> data,
      this.onViewButtonPressed,
      this.onEditButtonPressed}) {
    updateData(data);
  }

  late Map<SchoolClass, bool> _map;
  List<SchoolClass> _data = [];
  final Function(SchoolClass schoolClass)? onViewButtonPressed;
  final Function(SchoolClass schoolClass)? onEditButtonPressed;

  List<SchoolClass> get selectedData {
    List<SchoolClass> selectedRows = [
      for (var s in _map.entries)
        if (s.value == true) s.key
    ];

    return selectedRows;
  }

  selectAll(bool value) {
    notifyListeners();
  }

  updateData(List<SchoolClass> data) {
    _data = data;
    _map = {
      for (var schoolClass in _data) schoolClass: _map[schoolClass] ?? false
    };

    notifyListeners();
  }

  void sort<T>(Comparable<T> Function(SchoolClass s) getField, bool ascending) {
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
          DataCell(Text(_data[index].subjectCode)),
          DataCell(Text(_data[index].name)),
          DataCell(Text(_data[index].section)),
          DataCell(FutureBuilder(
            future: _data[index].teacher,
            builder: (context, snapshot) => snapshot.hasData
                ? Text(snapshot.data!.fullName)
                : const CircularProgressIndicator(),
          )),
          DataCell(Text(_data[index].getSchedule())),
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
