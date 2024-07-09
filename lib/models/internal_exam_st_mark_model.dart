// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class InternalExamStudentMarkModel {
  int? internal_exam_id;
  int? student_id;
  int? semester;
  int? pass_mark;
  int? full_mark;
  int? mark_obtain;
  String? subject_name;
  String? subject_code;
  String? internal_name;
  InternalExamStudentMarkModel({
    this.internal_exam_id,
    this.student_id,
    this.semester,
    this.pass_mark,
    this.full_mark,
    this.mark_obtain,
    this.subject_name,
    this.subject_code,
    this.internal_name,
  });

  InternalExamStudentMarkModel copyWith({
    int? internal_exam_id,
    int? student_id,
    int? semester,
    int? pass_mark,
    int? full_mark,
    int? mark_obtain,
    String? subject_name,
    String? subject_code,
    String? internal_name,
  }) {
    return InternalExamStudentMarkModel(
      internal_exam_id: internal_exam_id ?? this.internal_exam_id,
      student_id: student_id ?? this.student_id,
      semester: semester ?? this.semester,
      pass_mark: pass_mark ?? this.pass_mark,
      full_mark: full_mark ?? this.full_mark,
      mark_obtain: mark_obtain ?? this.mark_obtain,
      subject_name: subject_name ?? this.subject_name,
      subject_code: subject_code ?? this.subject_code,
      internal_name: internal_name ?? this.internal_name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'internal_exam_id': internal_exam_id,
      'student_id': student_id,
      'semester': semester,
      'pass_mark': pass_mark,
      'full_mark': full_mark,
      'mark_obtain': mark_obtain,
      'subject_name': subject_name,
      'subject_code': subject_code,
      'internal_name': internal_name,
    };
  }

  factory InternalExamStudentMarkModel.fromMap(Map<String, dynamic> map) {
    return InternalExamStudentMarkModel(
      internal_exam_id: map['internal_exam_id'] != null
          ? map['internal_exam_id'] as int
          : null,
      student_id: map['student_id'] != null ? map['student_id'] as int : null,
      semester: map['semester'] != null ? map['semester'] as int : null,
      pass_mark: map['pass_mark'] != null ? map['pass_mark'] as int : null,
      full_mark: map['full_mark'] != null ? map['full_mark'] as int : null,
      mark_obtain:
          map['mark_obtain'] != null ? map['mark_obtain'] as int : null,
      subject_name:
          map['subject_name'] != null ? map['subject_name'] as String : null,
      subject_code:
          map['subject_code'] != null ? map['subject_code'] as String : null,
      internal_name:
          map['internal_name'] != null ? map['internal_name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InternalExamStudentMarkModel.fromJson(String source) =>
      InternalExamStudentMarkModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InternalExamStudentMarkModel(internal_exam_id: $internal_exam_id, student_id: $student_id, semester: $semester, pass_mark: $pass_mark, full_mark: $full_mark, mark_obtain: $mark_obtain, subject_name: $subject_name, subject_code: $subject_code, internal_name: $internal_name)';
  }

  @override
  bool operator ==(covariant InternalExamStudentMarkModel other) {
    if (identical(this, other)) return true;

    return other.internal_exam_id == internal_exam_id &&
        other.student_id == student_id &&
        other.semester == semester &&
        other.pass_mark == pass_mark &&
        other.full_mark == full_mark &&
        other.mark_obtain == mark_obtain &&
        other.subject_name == subject_name &&
        other.subject_code == subject_code &&
        other.internal_name == internal_name;
  }

  @override
  int get hashCode {
    return internal_exam_id.hashCode ^
        student_id.hashCode ^
        semester.hashCode ^
        pass_mark.hashCode ^
        full_mark.hashCode ^
        mark_obtain.hashCode ^
        subject_name.hashCode ^
        subject_code.hashCode ^
        internal_name.hashCode;
  }
}
