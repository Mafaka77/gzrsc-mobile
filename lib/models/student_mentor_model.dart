// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StudentMentorModel {
  int? id;
  int? student_id;
  int? programme_id;
  int? specialization_id;
  int? batch_id;
  int? faculty_id;
  int? semester;
  StudentMentorModel({
    this.id,
    this.student_id,
    this.programme_id,
    this.specialization_id,
    this.batch_id,
    this.faculty_id,
    this.semester,
  });

  StudentMentorModel copyWith({
    int? id,
    int? student_id,
    int? programme_id,
    int? specialization_id,
    int? batch_id,
    int? faculty_id,
    int? semester,
  }) {
    return StudentMentorModel(
      id: id ?? this.id,
      student_id: student_id ?? this.student_id,
      programme_id: programme_id ?? this.programme_id,
      specialization_id: specialization_id ?? this.specialization_id,
      batch_id: batch_id ?? this.batch_id,
      faculty_id: faculty_id ?? this.faculty_id,
      semester: semester ?? this.semester,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'student_id': student_id,
      'programme_id': programme_id,
      'specialization_id': specialization_id,
      'batch_id': batch_id,
      'faculty_id': faculty_id,
      'semester': semester,
    };
  }

  factory StudentMentorModel.fromMap(Map<String, dynamic> map) {
    return StudentMentorModel(
      id: map['id'] != null ? map['id'] as int : null,
      student_id: map['student_id'] != null ? map['student_id'] as int : null,
      programme_id:
          map['programme_id'] != null ? map['programme_id'] as int : null,
      specialization_id: map['specialization_id'] != null
          ? map['specialization_id'] as int
          : null,
      batch_id: map['batch_id'] != null ? map['batch_id'] as int : null,
      faculty_id: map['faculty_id'] != null ? map['faculty_id'] as int : null,
      semester: map['semester'] != null ? map['semester'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentMentorModel.fromJson(String source) =>
      StudentMentorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StudentMentorModel(id: $id, student_id: $student_id, programme_id: $programme_id, specialization_id: $specialization_id, batch_id: $batch_id, faculty_id: $faculty_id, semester: $semester)';
  }

  @override
  bool operator ==(covariant StudentMentorModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.student_id == student_id &&
        other.programme_id == programme_id &&
        other.specialization_id == specialization_id &&
        other.batch_id == batch_id &&
        other.faculty_id == faculty_id &&
        other.semester == semester;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        student_id.hashCode ^
        programme_id.hashCode ^
        specialization_id.hashCode ^
        batch_id.hashCode ^
        faculty_id.hashCode ^
        semester.hashCode;
  }
}
