import 'package:a_check_web/model/school.dart';
import 'package:a_check_web/widgets/schedule_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ScheduleDialogState extends State<ScheduleDialog> {
  int? selectedDay;
  TimeOfDay? startTime, endTime;

  void onDropdownChanged(int? value) => setState(() => selectedDay = value);

  void setStartTime() async {
    TimeOfDay? value = await showTimePicker(
        context: context,
        initialTime: startTime != null ? startTime! : TimeOfDay.now());

    setState(() => startTime = value);
  }

  void setEndTime() async {
    TimeOfDay? value = await showTimePicker(
        context: context,
        initialTime: endTime != null ? endTime! : TimeOfDay.now());

    setState(() => endTime = value);
  }

  void finalizeSchedule() {
    if (startTime == null || endTime == null || selectedDay == null) {
      Fluttertoast.showToast(msg: "There must be a set day and time!");
      return;
    }

    if (!_isSelectedTimeValid()) {
      Fluttertoast.showToast(msg: "Invalid time range!");
      return;
    }

    final schedule = ClassSchedule.usingTimeOfDay(
        weekday: selectedDay!, startTime: startTime!, endTime: endTime!);

    Navigator.pop(context, schedule);
  }

  bool _isSelectedTimeValid() {
    final now = DateTime.now();
    final start = DateTime(
        now.year, now.month, now.day, startTime!.hour, startTime!.minute);
    final end =
        DateTime(now.year, now.month, now.day, endTime!.hour, endTime!.minute);

    return start.isBefore(end);
  }

  @override
  void initState() {
    super.initState();

    if (widget.schedule != null) {
      selectedDay = widget.schedule!.weekday;
      startTime = widget.schedule!.getStartTime();
      endTime = widget.schedule!.getEndTime();
    }
  }

  @override
  Widget build(BuildContext context) => ScheduleDialogView(this);
}
