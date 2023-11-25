import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'school_class.g.dart';

const firestoreSerializable = JsonSerializable(
    converters: firestoreJsonConverters,
    explicitToJson: true,
    createFieldMap: true,
    createPerFieldToJson: true);

@Collection<SchoolClass>('classes')
@Collection<ClassSchedule>('classes/*/schedule')
@firestoreSerializable
class SchoolClass {
  SchoolClass(
      {required this.id,
      required this.subjectCode,
      required this.name,
      required this.section,
      required this.schedule,
      required this.studentIds});

  factory SchoolClass.fromJson(Map<String, Object?> json) =>
      _$SchoolClassFromJson(json);

  @Id()
  final String id;

  final String subjectCode;
  final String name;
  final String section;
  final List<ClassSchedule> schedule;
  final Set<String> studentIds;

  Map<String, Object?> toJson() => _$SchoolClassToJson(this);
}

@firestoreSerializable
class ClassSchedule {
  ClassSchedule(
      {required this.weekday,
      required this.startTimeHour,
      required this.startTimeMinute,
      required this.endTimeHour,
      required this.endTimeMinute});

  ClassSchedule.usingTimeOfDay(
      {required this.weekday,
      required TimeOfDay startTime,
      required TimeOfDay endTime}) {
    startTimeHour = startTime.hour;
    startTimeMinute = startTime.minute;
    endTimeHour = endTime.hour;
    endTimeMinute = endTime.minute;
  }

  factory ClassSchedule.fromJson(Map<String, Object?> json) =>
      _$ClassScheduleFromJson(json);
  Map<String, Object?> toJson() => _$ClassScheduleToJson(this);

  int weekday;
  late int startTimeHour, startTimeMinute;
  late int endTimeHour, endTimeMinute;
}

final classesRef = SchoolClassCollectionReference();