// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:lms/models/semester_exam_fee_model.dart';

class SemesterSubjectExamFeeModel {
  int? id;
  int? department_id;
  int? programme_id;
  int? specialization_id;
  String? name;
  String? code;
  int? semester;
  String? programme_name;
  String? programme_code;
  String? specialization_name;
  String? amount;
  int? sId;
  SemesterSubjectExamFeeModel({
    this.id,
    this.department_id,
    this.programme_id,
    this.specialization_id,
    this.name,
    this.code,
    this.semester,
    this.programme_name,
    this.programme_code,
    this.specialization_name,
    this.amount,
    this.sId,
  });

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'id': id,
  //     'department_id': department_id,
  //     'programme_id': programme_id,
  //     'specialization_id': specialization_id,
  //     'name': name,
  //     'code': code,
  //     'semester': semester,
  //     'programme_name': programme_name,
  //     'programme_code': programme_code,
  //     'specialization_name': specialization_name,
  //     'semesterModel': semesterModel.map((x) => x?.toMap()).toList(),
  //   };
  // }

  factory SemesterSubjectExamFeeModel.fromMap(Map<String, dynamic> map) {
    return SemesterSubjectExamFeeModel(
      id: map['id'] != null ? map['id'] as int : null,
      department_id:
          map['department_id'] != null ? map['department_id'] as int : null,
      programme_id:
          map['programme_id'] != null ? map['programme_id'] as int : null,
      specialization_id: map['specialization_id'] != null
          ? map['specialization_id'] as int
          : null,
      name: map['name'] != null ? map['name'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      semester: map['semester'] != null ? map['semester'] as int : null,
      programme_name: map['programme_name'] != null
          ? map['programme_name'] as String
          : null,
      programme_code: map['programme_code'] != null
          ? map['programme_code'] as String
          : null,
      specialization_name: map['specialization_name'] != null
          ? map['specialization_name'] as String
          : null,
      amount: map['amount'] != null ? map['amount'] as String : null,
      sId: map['sId'] != null ? map['sId'] as int : null,
    );
  }

  // String toJson() => json.encode(toMap());

  factory SemesterSubjectExamFeeModel.fromJson(String source) =>
      SemesterSubjectExamFeeModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant SemesterSubjectExamFeeModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.department_id == department_id &&
        other.programme_id == programme_id &&
        other.specialization_id == specialization_id &&
        other.name == name &&
        other.code == code &&
        other.semester == semester &&
        other.programme_name == programme_name &&
        other.programme_code == programme_code &&
        other.specialization_name == specialization_name &&
        other.amount == amount &&
        other.sId == sId;
  }

  SemesterSubjectExamFeeModel copyWith({
    int? id,
    int? department_id,
    int? programme_id,
    int? specialization_id,
    String? name,
    String? code,
    int? semester,
    String? programme_name,
    String? programme_code,
    String? specialization_name,
    String? amount,
    int? sId,
  }) {
    return SemesterSubjectExamFeeModel(
      id: id ?? this.id,
      department_id: department_id ?? this.department_id,
      programme_id: programme_id ?? this.programme_id,
      specialization_id: specialization_id ?? this.specialization_id,
      name: name ?? this.name,
      code: code ?? this.code,
      semester: semester ?? this.semester,
      programme_name: programme_name ?? this.programme_name,
      programme_code: programme_code ?? this.programme_code,
      specialization_name: specialization_name ?? this.specialization_name,
      amount: amount ?? this.amount,
      sId: sId ?? this.sId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'department_id': department_id,
      'programme_id': programme_id,
      'specialization_id': specialization_id,
      'name': name,
      'code': code,
      'semester': semester,
      'programme_name': programme_name,
      'programme_code': programme_code,
      'specialization_name': specialization_name,
      'amount': amount,
      'sId': sId,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'SemesterSubjectExamFeeModel(id: $id, department_id: $department_id, programme_id: $programme_id, specialization_id: $specialization_id, name: $name, code: $code, semester: $semester, programme_name: $programme_name, programme_code: $programme_code, specialization_name: $specialization_name, amount: $amount, sId: $sId)';
  }

  @override
  int get hashCode {
    return id.hashCode ^
        department_id.hashCode ^
        programme_id.hashCode ^
        specialization_id.hashCode ^
        name.hashCode ^
        code.hashCode ^
        semester.hashCode ^
        programme_name.hashCode ^
        programme_code.hashCode ^
        specialization_name.hashCode ^
        amount.hashCode ^
        sId.hashCode;
  }
}
