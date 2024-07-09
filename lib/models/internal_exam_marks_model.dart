// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class InternalExamMarksModel {
  int? internal_exam_id;
  int? student_id;
  int? batch_id;
  int? semester;
  int? subject_id;
  int? pass_mark;
  int? full_mark;
  int? mark_obtain;
  String? status;
  String? name;
  String? mzu_regn_no;
  int? entry_by;
  String? programme_code;
  String? specialization;
  int? noOfSemester;
  String? internal_exam;
  InternalExamMarksModel({
    this.internal_exam_id,
    this.student_id,
    this.batch_id,
    this.semester,
    this.subject_id,
    this.pass_mark,
    this.full_mark,
    this.mark_obtain,
    this.status,
    this.name,
    this.mzu_regn_no,
    this.entry_by,
    this.programme_code,
    this.specialization,
    this.noOfSemester,
    this.internal_exam,
  });

  InternalExamMarksModel copyWith({
    int? internal_exam_id,
    int? student_id,
    int? batch_id,
    int? semester,
    int? subject_id,
    int? pass_mark,
    int? full_mark,
    int? mark_obtain,
    String? status,
    String? name,
    String? mzu_regn_no,
    int? entry_by,
    String? programme_code,
    String? specialization,
    int? noOfSemester,
    String? internal_exam,
  }) {
    return InternalExamMarksModel(
      internal_exam_id: internal_exam_id ?? this.internal_exam_id,
      student_id: student_id ?? this.student_id,
      batch_id: batch_id ?? this.batch_id,
      semester: semester ?? this.semester,
      subject_id: subject_id ?? this.subject_id,
      pass_mark: pass_mark ?? this.pass_mark,
      full_mark: full_mark ?? this.full_mark,
      mark_obtain: mark_obtain ?? this.mark_obtain,
      status: status ?? this.status,
      name: name ?? this.name,
      mzu_regn_no: mzu_regn_no ?? this.mzu_regn_no,
      entry_by: entry_by ?? this.entry_by,
      programme_code: programme_code ?? this.programme_code,
      specialization: specialization ?? this.specialization,
      noOfSemester: noOfSemester ?? this.noOfSemester,
      internal_exam: internal_exam ?? this.internal_exam,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'internal_exam_id': internal_exam_id,
      'student_id': student_id,
      'batch_id': batch_id,
      'semester': semester,
      'subject_id': subject_id,
      'pass_mark': pass_mark,
      'full_mark': full_mark,
      'mark_obtain': mark_obtain,
      'status': status,
      'name': name,
      'mzu_regn_no': mzu_regn_no,
      'entry_by': entry_by,
      'programme_code': programme_code,
      'specialization': specialization,
      'noOfSemester': noOfSemester,
      'internal_exam': internal_exam,
    };
  }

  factory InternalExamMarksModel.fromMap(Map<String, dynamic> map) {
    return InternalExamMarksModel(
      internal_exam_id: map['internal_exam_id'] != null
          ? map['internal_exam_id'] as int
          : null,
      student_id: map['student_id'] != null ? map['student_id'] as int : null,
      batch_id: map['batch_id'] != null ? map['batch_id'] as int : null,
      semester: map['semester'] != null ? map['semester'] as int : null,
      subject_id: map['subject_id'] != null ? map['subject_id'] as int : null,
      pass_mark: map['pass_mark'] != null ? map['pass_mark'] as int : null,
      full_mark: map['full_mark'] != null ? map['full_mark'] as int : null,
      mark_obtain:
          map['mark_obtain'] != null ? map['mark_obtain'] as int : null,
      status: map['status'] != null ? map['status'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      mzu_regn_no:
          map['mzu_regn_no'] != null ? map['mzu_regn_no'] as String : null,
      entry_by: map['entry_by'] != null ? map['entry_by'] as int : null,
      programme_code: map['programme_code'] != null
          ? map['programme_code'] as String
          : null,
      specialization: map['specialization'] != null
          ? map['specialization'] as String
          : null,
      noOfSemester:
          map['noOfSemester'] != null ? map['noOfSemester'] as int : null,
      internal_exam:
          map['internal_exam'] != null ? map['internal_exam'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InternalExamMarksModel.fromJson(String source) =>
      InternalExamMarksModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InternalExamMarksModel(internal_exam_id: $internal_exam_id, student_id: $student_id, batch_id: $batch_id, semester: $semester, subject_id: $subject_id, pass_mark: $pass_mark, full_mark: $full_mark, mark_obtain: $mark_obtain, status: $status, name: $name, mzu_regn_no: $mzu_regn_no, entry_by: $entry_by, programme_code: $programme_code, specialization: $specialization, noOfSemester: $noOfSemester, internal_exam: $internal_exam)';
  }

  @override
  bool operator ==(covariant InternalExamMarksModel other) {
    if (identical(this, other)) return true;

    return other.internal_exam_id == internal_exam_id &&
        other.student_id == student_id &&
        other.batch_id == batch_id &&
        other.semester == semester &&
        other.subject_id == subject_id &&
        other.pass_mark == pass_mark &&
        other.full_mark == full_mark &&
        other.mark_obtain == mark_obtain &&
        other.status == status &&
        other.name == name &&
        other.mzu_regn_no == mzu_regn_no &&
        other.entry_by == entry_by &&
        other.programme_code == programme_code &&
        other.specialization == specialization &&
        other.noOfSemester == noOfSemester &&
        other.internal_exam == internal_exam;
  }

  @override
  int get hashCode {
    return internal_exam_id.hashCode ^
        student_id.hashCode ^
        batch_id.hashCode ^
        semester.hashCode ^
        subject_id.hashCode ^
        pass_mark.hashCode ^
        full_mark.hashCode ^
        mark_obtain.hashCode ^
        status.hashCode ^
        name.hashCode ^
        mzu_regn_no.hashCode ^
        entry_by.hashCode ^
        programme_code.hashCode ^
        specialization.hashCode ^
        noOfSemester.hashCode ^
        internal_exam.hashCode;
  }
}
