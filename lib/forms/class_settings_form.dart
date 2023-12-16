import 'package:a_check_web/globals.dart';
import 'package:a_check_web/model/school.dart';
import 'package:a_check_web/utils/abstracts.dart';
import 'package:a_check_web/utils/csv_helpers.dart';
import 'package:a_check_web/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ClassSettingsForm extends StatefulWidget {
  const ClassSettingsForm({super.key, required this.schoolClass});

  final SchoolClass schoolClass;

  @override
  State<ClassSettingsForm> createState() => ClassSettingsState();
}

class ClassSettingsState extends State<ClassSettingsForm> {
  @override
  Widget build(BuildContext context) => ClassSettingsView(this);

  @override
  void initState() {
    super.initState();

    maxAbsenceCon = TextEditingController();

    maxAbsenceCon.text = widget.schoolClass.maxAbsences.toString();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController maxAbsenceCon;

  cancel() {
    Navigator.pop(context);
  }

  finalize() {
    if (!formKey.currentState!.validate()) return;

    classesRef
        .doc(widget.schoolClass.id)
        .update(maxAbsences: int.parse(maxAbsenceCon.text))
        .then((_) {
      snackbarKey.currentState!.showSnackBar(SnackBar(
          content: Text(
              "Successfully edited ${widget.schoolClass.id}'s settings!")));
      Navigator.pop(context);
    });
  }

  void exportDialog() async {
    final classRecords = (await attendancesRef
            .whereClassId(isEqualTo: widget.schoolClass.id)
            .get())
        .docs
        .map((e) => e.data)
        .toList()
      ..sort(
        (a, b) => a.dateTime.compareTo(b.dateTime),
      );

    if (!mounted) return;
    final DateTimeRange? result = await showDateRangePicker(
        context: context,
        firstDate: classRecords.first.dateTime,
        lastDate: classRecords.last.dateTime);
    if (result == null) return;

    final Map<DateTime, List<AttendanceRecord>> map = {};
    for (var s in classRecords) {
      if (s.dateTime.isAfter(result.start) && s.dateTime.isBefore(result.end)) {
        final date =
            DateTime(s.dateTime.year, s.dateTime.month, s.dateTime.day);

        if (!map.containsKey(date)) {
          map[date] = [];
        }

        map[date]!.add(s);
      }
    }

    await _exportRecords(map);
  }

  Future<void> _exportRecords(
      Map<DateTime, List<AttendanceRecord>> records) async {
    final now = DateTime.now();
    final records = Map.fromEntries(
        (await widget.schoolClass.getAttendanceRecords()).entries.toList()
          ..sort(
            (a, b) => a.key.compareTo(b.key),
          ));
    Map<String, List<AttendanceRecord>> map = {};

    for (var entry in records.entries) {
      for (var record in entry.value) {
        final id = record.studentId;
        if (!map.containsKey(id)) {
          map[id] = [];
        }

        try {
          // check if this record exists
          // will throw StateError if it doesnt exist
          // otherwise, do nothing
          map[id]?.firstWhere((element) =>
              DateUtils.isSameDay(element.dateTime, record.dateTime));
        } on StateError {
          // add new record
          map[id]!.add(record);
        }
      }
    }

    final header = [
      "ID",
      "Last Name",
      "First Name",
      "Middle Name",
      for (var date in records.keys) DateFormat.yMd().format(date).toString()
    ];
    final List<List<dynamic>> data = [];

    for (var entry in map.entries) {
      final student = (await studentsRef.doc(entry.key).get()).data!;
      final row = <dynamic>[
        student.id,
        student.lastName,
        student.firstName,
        student.lastName
      ];

      for (var record in entry.value) {
        row.add(record.status.toString());
      }

      data.add(row);
    }

    await CsvHelpers.exportToCsvFile(
            fileName: "${widget.schoolClass.id}-${now.toString()}",
            header: header,
            data: data)
        .whenComplete(() {
      snackbarKey.currentState!.showSnackBar(const SnackBar(
          content: Text(
              "Successfully exported class attendance records as CSV file!")));
    });
  }
}

class ClassSettingsView
    extends WidgetView<ClassSettingsForm, ClassSettingsState> {
  const ClassSettingsView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 440,
      height: 230,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildForm()
          // buildButtons()
        ],
      ),
    );
  }

  Form buildForm() {
    return Form(
      key: state.formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text("Class Settings",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 27,
                    color: Color(0xff000000),
                  )),
            ),
            const Divider(thickness: 1,),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                  flex: 3,
                  child: Text("Edit Absence Limit",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    controller: state.maxAbsenceCon,
                    validator: Validators.hasValue,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    obscureText: false,
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(4),
                      suffixIcon:
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const VerticalDivider(thickness: 3, color: Colors.blue, width: 2,),
                              Tooltip(message: "Save changes",
                              child: InkWell(
                                radius: 10,
                                onTap: state.finalize,
                                child: const Icon(Icons.check_circle, color: Color(0xff153faa),),
                              ),
                            ),
                          ],
                        ),
                        filled: true,
                        fillColor: const Color(0xffFAF9FE),
                        focusColor: const Color(0xff153faa),
                        enabled: true,
                        border: OutlineInputBorder(borderRadius:BorderRadius.circular(15.0)),
                        hintText: 'Default value: 3', alignLabelWithHint: true),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: state.exportDialog,
              label: const Text("Export All Class Attendance Records"),
              icon: const Icon(Icons.download_rounded, size: 16),
              style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(35)),
            )
          ],
        ),
      ),
    );
  }

  Row buildButtons() {
    return Row(
      children: [
        Material(
          color: Colors.grey.shade100,
          child: InkWell(
            hoverColor: Colors.grey.withOpacity(0.4),
            highlightColor: Colors.grey.withOpacity(0.4),
            splashColor: Colors.grey.withOpacity(0.5),
            onTap: state.cancel,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 24),
              width: 225,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                // adding color will hide the splash effect
                // color: Colors.blueGrey.shade200,
              ),
              child: const Text(
                "Cancel",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        Material(
          color: const Color(0xff153faa).withOpacity(0.6),
          child: InkWell(
            hoverColor: const Color(0xff153faa).withOpacity(0.8),
            highlightColor: const Color(0xff153faa).withOpacity(0.4),
            splashColor: const Color(0xff153faa).withOpacity(1),
            onTap: state.finalize,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 24),
              width: 225,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                // adding color will hide the splash effect
                // color: Colors.blueGrey.shade200,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Confirm",
                    style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
