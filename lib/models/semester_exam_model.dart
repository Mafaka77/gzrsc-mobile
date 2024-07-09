// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SemesterExamModel {
  int? id;
  int? student_id;
  int? batch_id;
  int? semester;
  int? subject_id;
  String? score;
  String? status;
  int? entry_by;
  String? subject_name;
  String? subject_code;
  SemesterExamModel({
    this.id,
    this.student_id,
    this.batch_id,
    this.semester,
    this.subject_id,
    this.score,
    this.status,
    this.entry_by,
    this.subject_name,
    this.subject_code,
  });

  SemesterExamModel copyWith({
    int? id,
    int? student_id,
    int? batch_id,
    int? semester,
    int? subject_id,
    String? score,
    String? status,
    int? entry_by,
    String? subject_name,
    String? subject_code,
  }) {
    return SemesterExamModel(
      id: id ?? this.id,
      student_id: student_id ?? this.student_id,
      batch_id: batch_id ?? this.batch_id,
      semester: semester ?? this.semester,
      subject_id: subject_id ?? this.subject_id,
      score: score ?? this.score,
      status: status ?? this.status,
      entry_by: entry_by ?? this.entry_by,
      subject_name: subject_name ?? this.subject_name,
      subject_code: subject_code ?? this.subject_code,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'student_id': student_id,
      'batch_id': batch_id,
      'semester': semester,
      'subject_id': subject_id,
      'score': score,
      'status': status,
      'entry_by': entry_by,
      'subject_name': subject_name,
      'subject_code': subject_code,
    };
  }

  factory SemesterExamModel.fromMap(Map<String, dynamic> map) {
    return SemesterExamModel(
      id: map['id'] != null ? map['id'] as int : null,
      student_id: map['student_id'] != null ? map['student_id'] as int : null,
      batch_id: map['batch_id'] != null ? map['batch_id'] as int : null,
      semester: map['semester'] != null ? map['semester'] as int : null,
      subject_id: map['subject_id'] != null ? map['subject_id'] as int : null,
      score: map['score'] != null ? map['score'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      entry_by: map['entry_by'] != null ? map['entry_by'] as int : null,
      subject_name:
          map['subject_name'] != null ? map['subject_name'] as String : null,
      subject_code:
          map['subject_code'] != null ? map['subject_code'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SemesterExamModel.fromJson(String source) =>
      SemesterExamModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SemesterExamModel(id: $id, student_id: $student_id, batch_id: $batch_id, semester: $semester, subject_id: $subject_id, score: $score, status: $status, entry_by: $entry_by, subject_name: $subject_name, subject_code: $subject_code)';
  }

  @override
  bool operator ==(covariant SemesterExamModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.student_id == student_id &&
        other.batch_id == batch_id &&
        other.semester == semester &&
        other.subject_id == subject_id &&
        other.score == score &&
        other.status == status &&
        other.entry_by == entry_by &&
        other.subject_name == subject_name &&
        other.subject_code == subject_code;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        student_id.hashCode ^
        batch_id.hashCode ^
        semester.hashCode ^
        subject_id.hashCode ^
        score.hashCode ^
        status.hashCode ^
        entry_by.hashCode ^
        subject_name.hashCode ^
        subject_code.hashCode;
  }
}
