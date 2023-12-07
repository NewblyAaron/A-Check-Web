import 'package:a_check_web/forms/class_form.dart';
import 'package:a_check_web/globals.dart';
import 'package:a_check_web/model/school_class.dart';

import 'package:a_check_web/pages/class/class_list.dart';
import 'package:a_check_web/utils/dialogs.dart';
import 'package:a_check_web/widgets/cell_actions.dart';
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

    widget.searchController?.addListener(filter);
  }

  @override
  void dispose() {
    super.dispose();

    widget.searchController?.removeListener(filter);
  }

  late final ClassDataSource rows;
  int sortColumnIndex = 0;
  bool sortAscending = false;

  filter() {
    setState(() => rows.filter(widget.searchController!.text));
  }

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

  final Function(SchoolClass schoolClass)? onViewButtonPressed;
  final Function(SchoolClass schoolClass)? onEditButtonPressed;

  late Map<SchoolClass, bool> _map;
  List<SchoolClass> _data = [];
  List<SchoolClass> _filteredData = [];
  bool _filtered = false;

  List<SchoolClass> get selectedData {
    List<SchoolClass> selectedRows = [
      for (var s in _map.entries)
        if (s.value == true) s.key
    ];

    return selectedRows;
  }

  selectAll(bool? value) {
    _map.updateAll((_, v) => v = value ?? false);
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
      if (s.id.toLowerCase().contains(filter) ||
          s.name.toLowerCase().contains(filter)) {
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
          DataCell(Text(data[index].subjectCode,
              style: const TextStyle(fontSize: 12))),
          DataCell(
              Text(data[index].name, style: const TextStyle(fontSize: 12))),
          DataCell(
              Text(data[index].section, style: const TextStyle(fontSize: 12))),
          DataCell(FutureBuilder(
            future: data[index].teacher,
            builder: (context, snapshot) => snapshot.hasData
                ? Text(snapshot.data!.fullName,
                    style: const TextStyle(fontSize: 12))
                : const CircularProgressIndicator(),
          )),
          DataCell(Text(data[index].getSchedule())),
          DataCell(
            CellActions(
              data: data[index],
              onViewButtonPressed: (o) => onViewButtonPressed,
              onEditButtonPressed: (o) => onEditButtonPressed,
              viewTooltip: "View class info",
              editTooltip: "Edit class info",
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
