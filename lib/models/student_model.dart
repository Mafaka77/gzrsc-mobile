// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:lms/models/student_mentor_model.dart';

class StudentModel {
  int? id;
  int? batch_id;
  int? programme_id;
  int? specialization_id;
  String? mzu_regn_no;
  String? full_name;
  int? current_semester;
  String? start_year;
  String? end_year;
  String? programme_name;
  String? programme_code;
  String? specialization_name;
  int? programme_semester;
  bool? isSelected;
  List<StudentMentorModel>? student_mentor;
  StudentModel({
    this.id,
    this.batch_id,
    this.programme_id,
    this.specialization_id,
    this.mzu_regn_no,
    this.full_name,
    this.current_semester,
    this.start_year,
    this.end_year,
    this.programme_name,
    this.programme_code,
    this.specialization_name,
    this.programme_semester,
    this.isSelected,
    this.student_mentor,
  });

  StudentModel copyWith({
    int? id,
    int? batch_id,
    int? programme_id,
    int? specialization_id,
    String? mzu_regn_no,
    String? full_name,
    int? current_semester,
    String? start_year,
    String? end_year,
    String? programme_name,
    String? programme_code,
    String? specialization_name,
    int? programme_semester,
    bool? isSelected,
    List<StudentMentorModel>? student_mentor,
  }) {
    return StudentModel(
      id: id ?? this.id,
      batch_id: batch_id ?? this.batch_id,
      programme_id: programme_id ?? this.programme_id,
      specialization_id: specialization_id ?? this.specialization_id,
      mzu_regn_no: mzu_regn_no ?? this.mzu_regn_no,
      full_name: full_name ?? this.full_name,
      current_semester: current_semester ?? this.current_semester,
      start_year: start_year ?? this.start_year,
      end_year: end_year ?? this.end_year,
      programme_name: programme_name ?? this.programme_name,
      programme_code: programme_code ?? this.programme_code,
      specialization_name: specialization_name ?? this.specialization_name,
      programme_semester: programme_semester ?? this.programme_semester,
      isSelected: isSelected ?? this.isSelected,
      student_mentor: student_mentor ?? this.student_mentor,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'id': id,
  //     'batch_id': batch_id,
  //     'programme_id': programme_id,
  //     'specialization_id': specialization_id,
  //     'mzu_regn_no': mzu_regn_no,
  //     'full_name': full_name,
  //     'current_semester': current_semester,
  //     'start_year': start_year,
  //     'end_year': end_year,
  //     'programme_name': programme_name,
  //     'programme_code': programme_code,
  //     'specialization_name': specialization_name,
  //     'programme_semester': programme_semester,
  //     'isSelected': isSelected,
  //     'student_mentor': student_mentor.map((x) => x?.toMap()).toList(),
  //   };
  // }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map['id'] != null ? map['id'] as int : null,
      batch_id: map['batch_id'] != null ? map['batch_id'] as int : null,
      programme_id:
          map['programme_id'] != null ? map['programme_id'] as int : null,
      specialization_id: map['specialization_id'] != null
          ? map['specialization_id'] as int
          : null,
      mzu_regn_no:
          map['mzu_regn_no'] != null ? map['mzu_regn_no'] as String : null,
      full_name: map['full_name'] != null ? map['full_name'] as String : null,
      current_semester: map['current_semester'] != null
          ? map['current_semester'] as int
          : null,
      start_year:
          map['start_year'] != null ? map['start_year'] as String : null,
      end_year: map['end_year'] != null ? map['end_year'] as String : null,
      programme_name: map['programme_name'] != null
          ? map['programme_name'] as String
          : null,
      programme_code: map['programme_code'] != null
          ? map['programme_code'] as String
          : null,
      specialization_name: map['specialization_name'] != null
          ? map['specialization_name'] as String
          : null,
      programme_semester: map['programme_semester'] != null
          ? map['programme_semester'] as int
          : null,
      isSelected: map['isSelected'] != null ? map['isSelected'] as bool : null,
      student_mentor: map['student_mentor'] != null
          ? List<StudentMentorModel>.from(
              (map['student_mentor'] as List<int>).map<StudentMentorModel?>(
                (x) => StudentMentorModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  // String toJson() => json.encode(toMap());

  factory StudentModel.fromJson(String source) =>
      StudentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StudentModel(id: $id, batch_id: $batch_id, programme_id: $programme_id, specialization_id: $specialization_id, mzu_regn_no: $mzu_regn_no, full_name: $full_name, current_semester: $current_semester, start_year: $start_year, end_year: $end_year, programme_name: $programme_name, programme_code: $programme_code, specialization_name: $specialization_name, programme_semester: $programme_semester, isSelected: $isSelected, student_mentor: $student_mentor)';
  }

  @override
  bool operator ==(covariant StudentModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.batch_id == batch_id &&
        other.programme_id == programme_id &&
        other.specialization_id == specialization_id &&
        other.mzu_regn_no == mzu_regn_no &&
        other.full_name == full_name &&
        other.current_semester == current_semester &&
        other.start_year == start_year &&
        other.end_year == end_year &&
        other.programme_name == programme_name &&
        other.programme_code == programme_code &&
        other.specialization_name == specialization_name &&
        other.programme_semester == programme_semester &&
        other.isSelected == isSelected &&
        listEquals(other.student_mentor, student_mentor);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        batch_id.hashCode ^
        programme_id.hashCode ^
        specialization_id.hashCode ^
        mzu_regn_no.hashCode ^
        full_name.hashCode ^
        current_semester.hashCode ^
        start_year.hashCode ^
        end_year.hashCode ^
        programme_name.hashCode ^
        programme_code.hashCode ^
        specialization_name.hashCode ^
        programme_semester.hashCode ^
        isSelected.hashCode ^
        student_mentor.hashCode;
  }
}
