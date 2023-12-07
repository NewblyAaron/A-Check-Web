// ignore_for_file: constant_identifier_names

import 'package:a_check_web/model/person.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance_record.g.dart';

const firestoreSerializable = JsonSerializable(
    converters: firestoreJsonConverters,
    explicitToJson: true,
    createFieldMap: true,
    createPerFieldToJson: true);

@Collection<AttendanceRecord>('attendances')
@firestoreSerializable
class AttendanceRecord {
  AttendanceRecord({
    required this.id,
    required this.studentId,
    required this.classId,
    required this.dateTime,
    AttendanceStatus? status
  }) {
    this.status = status ?? AttendanceStatus.unknown;
  }

  factory AttendanceRecord.fromJson(Map<String, Object?> json) => _$AttendanceRecordFromJson(json);

  @Id()
  final String id;

  final String studentId;
  final String classId;
  final DateTime dateTime;
  late AttendanceStatus status;

  Map<String, Object?> toJson() => _$AttendanceRecordToJson(this);

  Future<Student> get student async => (await studentsRef.doc(studentId).get()).data!;
}

enum AttendanceStatus {
  @JsonValue(-1)
  unknown,
  @JsonValue(0)
  Absent,
  @JsonValue(1)
  Present,
  @JsonValue(2)
  Late,
  @JsonValue(3)
  Excused;
}

final attendancesRef = AttendanceRecordCollectionReference();