import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

const firestoreSerializable = JsonSerializable(
    converters: firestoreJsonConverters,
    explicitToJson: true,
    createFieldMap: true,
    createPerFieldToJson: true);

class Person {
  Person({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    this.email,
    this.phoneNumber,
  });

  final String firstName, middleName, lastName;
  final String? email, phoneNumber;
}

@Collection<Student>('students')
@firestoreSerializable
class Student extends Person {
  Student({
    required this.id,
    required super.firstName,
    required super.middleName,
    required super.lastName,
    super.email,
    super.phoneNumber,
    this.guardianIds,
  });

  factory Student.fromJson(Map<String, Object?> json) =>
      _$StudentFromJson(json);

  @Id()
  final String id;

  final List<String>? guardianIds;

  Map<String, Object?> toJson() => _$StudentToJson(this);
}

@Collection<Guardian>('guardians')
@firestoreSerializable
class Guardian extends Person {
  Guardian({
    required this.id,
    required super.firstName,
    required super.middleName,
    required super.lastName,
    super.email,
    super.phoneNumber,
  });

  factory Guardian.fromJson(Map<String, Object?> json) =>
      _$GuardianFromJson(json);

  @Id()
  final String id;

  Map<String, Object?> toJson() => _$GuardianToJson(this);
}

@Collection<Teacher>('teachers')
@firestoreSerializable
class Teacher extends Person {
  Teacher(
      {required this.id,
      required super.firstName,
      required super.middleName,
      required super.lastName,
      super.email,
      super.phoneNumber,
      this.classIds});

  factory Teacher.fromJson(Map<String, Object?> json) =>
      _$TeacherFromJson(json);

  @Id()
  final String id;

  final List<String>? classIds;

  Map<String, Object?> toJson() => _$TeacherToJson(this);
}

final studentsRef = StudentCollectionReference();
final guardiansRef = GuardianCollectionReference();
final teachersRef = TeacherCollectionReference();
