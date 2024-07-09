// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lms/models/program_model.dart';
import 'package:lms/models/subject_model.dart';

class SemesterExamFeeModel {
  int? id;
  int? programme_id;
  int? specialization_id;
  int? subject_id;
  int? semester;
  String? amount;
  int? year;
  String? status;
  String? programme_name;
  String? programme_code;
  String? subject_name;
  String? subject_code;
  ProgramModel? programModel;
  SubjectModel? subjectModel;
  SemesterExamFeeModel({
    this.id,
    this.programme_id,
    this.specialization_id,
    this.subject_id,
    this.semester,
    this.amount,
    this.year,
    this.status,
    this.programme_name,
    this.programme_code,
    this.subject_name,
    this.subject_code,
    this.programModel,
    this.subjectModel,
  });

  SemesterExamFeeModel copyWith({
    int? id,
    int? programme_id,
    int? specialization_id,
    int? subject_id,
    int? semester,
    String? amount,
    int? year,
    String? status,
    String? programme_name,
    String? programme_code,
    String? subject_name,
    String? subject_code,
    ProgramModel? programModel,
    SubjectModel? subjectModel,
  }) {
    return SemesterExamFeeModel(
      id: id ?? this.id,
      programme_id: programme_id ?? this.programme_id,
      specialization_id: specialization_id ?? this.specialization_id,
      subject_id: subject_id ?? this.subject_id,
      semester: semester ?? this.semester,
      amount: amount ?? this.amount,
      year: year ?? this.year,
      status: status ?? this.status,
      programme_name: programme_name ?? this.programme_name,
      programme_code: programme_code ?? this.programme_code,
      subject_name: subject_name ?? this.subject_name,
      subject_code: subject_code ?? this.subject_code,
      programModel: programModel ?? this.programModel,
      subjectModel: subjectModel ?? this.subjectModel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'programme_id': programme_id,
      'specialization_id': specialization_id,
      'subject_id': subject_id,
      'semester': semester,
      'amount': amount,
      'year': year,
      'status': status,
      'programme_name': programme_name,
      'programme_code': programme_code,
      'subject_name': subject_name,
      'subject_code': subject_code,
      'programModel': programModel?.toMap(),
      'subjectModel': subjectModel?.toMap(),
    };
  }

  factory SemesterExamFeeModel.fromMap(Map<String, dynamic> map) {
    return SemesterExamFeeModel(
      id: map['id'] != null ? map['id'] as int : null,
      programme_id:
          map['programme_id'] != null ? map['programme_id'] as int : null,
      specialization_id: map['specialization_id'] != null
          ? map['specialization_id'] as int
          : null,
      subject_id: map['subject_id'] != null ? map['subject_id'] as int : null,
      semester: map['semester'] != null ? map['semester'] as int : null,
      amount: map['amount'] != null ? map['amount'] as String : null,
      year: map['year'] != null ? map['year'] as int : null,
      status: map['status'] != null ? map['status'] as String : null,
      programme_name: map['programme_name'] != null
          ? map['programme_name'] as String
          : null,
      programme_code: map['programme_code'] != null
          ? map['programme_code'] as String
          : null,
      subject_name:
          map['subject_name'] != null ? map['subject_name'] as String : null,
      subject_code:
          map['subject_code'] != null ? map['subject_code'] as String : null,
      programModel: map['programme'] != null
          ? ProgramModel.fromMap(map['programme'] as Map<String, dynamic>)
          : null,
      subjectModel: map['subject'] != null
          ? SubjectModel.fromMap(map['subject'] as Map<String, dynamic>)
          : null,
    );
  }
  static List<SemesterExamFeeModel> fromJsonList(List list) {
    return list.map((e) => SemesterExamFeeModel.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory SemesterExamFeeModel.fromJson(String source) =>
      SemesterExamFeeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SemesterExamFeeModel(id: $id, programme_id: $programme_id, specialization_id: $specialization_id, subject_id: $subject_id, semester: $semester, amount: $amount, year: $year, status: $status, programme_name: $programme_name, programme_code: $programme_code, subject_name: $subject_name, subject_code: $subject_code, programModel: $programModel, subjectModel: $subjectModel)';
  }

  @override
  bool operator ==(covariant SemesterExamFeeModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.programme_id == programme_id &&
        other.specialization_id == specialization_id &&
        other.subject_id == subject_id &&
        other.semester == semester &&
        other.amount == amount &&
        other.year == year &&
        other.status == status &&
        other.programme_name == programme_name &&
        other.programme_code == programme_code &&
        other.subject_name == subject_name &&
        other.subject_code == subject_code &&
        other.programModel == programModel &&
        other.subjectModel == subjectModel;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        programme_id.hashCode ^
        specialization_id.hashCode ^
        subject_id.hashCode ^
        semester.hashCode ^
        amount.hashCode ^
        year.hashCode ^
        status.hashCode ^
        programme_name.hashCode ^
        programme_code.hashCode ^
        subject_name.hashCode ^
        subject_code.hashCode ^
        programModel.hashCode ^
        subjectModel.hashCode;
  }
}
