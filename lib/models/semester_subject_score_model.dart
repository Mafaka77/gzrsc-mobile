// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SemesterSubjectScoreModel {
  int? id;
  int? department_id;
  int? programme_id;
  int? specialization_id;
  String? name;
  String? code;
  int? semester;
  String? type;
  String? credit;
  String? elective;
  String? active;
  int? student_id;
  int? batch_id;
  int? subject_id;
  String? score;
  int? entry_by;
  int? semester_exam_id;
  SemesterSubjectScoreModel({
    this.id,
    this.department_id,
    this.programme_id,
    this.specialization_id,
    this.name,
    this.code,
    this.semester,
    this.type,
    this.credit,
    this.elective,
    this.active,
    this.student_id,
    this.batch_id,
    this.subject_id,
    this.score,
    this.entry_by,
    this.semester_exam_id,
  });

  SemesterSubjectScoreModel copyWith({
    int? id,
    int? department_id,
    int? programme_id,
    int? specialization_id,
    String? name,
    String? code,
    int? semester,
    String? type,
    String? credit,
    String? elective,
    String? active,
    int? student_id,
    int? batch_id,
    int? subject_id,
    String? score,
    int? entry_by,
    int? semester_exam_id,
  }) {
    return SemesterSubjectScoreModel(
      id: id ?? this.id,
      department_id: department_id ?? this.department_id,
      programme_id: programme_id ?? this.programme_id,
      specialization_id: specialization_id ?? this.specialization_id,
      name: name ?? this.name,
      code: code ?? this.code,
      semester: semester ?? this.semester,
      type: type ?? this.type,
      credit: credit ?? this.credit,
      elective: elective ?? this.elective,
      active: active ?? this.active,
      student_id: student_id ?? this.student_id,
      batch_id: batch_id ?? this.batch_id,
      subject_id: subject_id ?? this.subject_id,
      score: score ?? this.score,
      entry_by: entry_by ?? this.entry_by,
      semester_exam_id: semester_exam_id ?? this.semester_exam_id,
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
      'type': type,
      'credit': credit,
      'elective': elective,
      'active': active,
      'student_id': student_id,
      'batch_id': batch_id,
      'subject_id': subject_id,
      'score': score,
      'entry_by': entry_by,
      'semester_exam_id': semester_exam_id,
    };
  }

  factory SemesterSubjectScoreModel.fromMap(Map<String, dynamic> map) {
    return SemesterSubjectScoreModel(
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
      type: map['type'] != null ? map['type'] as String : null,
      credit: map['credit'] != null ? map['credit'] as String : null,
      elective: map['elective'] != null ? map['elective'] as String : null,
      active: map['active'] != null ? map['active'] as String : null,
      student_id: map['student_id'] != null ? map['student_id'] as int : null,
      batch_id: map['batch_id'] != null ? map['batch_id'] as int : null,
      subject_id: map['subject_id'] != null ? map['subject_id'] as int : null,
      score: map['score'] != null ? map['score'] as String : null,
      entry_by: map['entry_by'] != null ? map['entry_by'] as int : null,
      semester_exam_id: map['semester_exam_id'] != null
          ? map['semester_exam_id'] as int
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SemesterSubjectScoreModel.fromJson(String source) =>
      SemesterSubjectScoreModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SemesterSubjectScoreModel(id: $id, department_id: $department_id, programme_id: $programme_id, specialization_id: $specialization_id, name: $name, code: $code, semester: $semester, type: $type, credit: $credit, elective: $elective, active: $active, student_id: $student_id, batch_id: $batch_id, subject_id: $subject_id, score: $score, entry_by: $entry_by, semester_exam_id: $semester_exam_id)';
  }

  @override
  bool operator ==(covariant SemesterSubjectScoreModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.department_id == department_id &&
        other.programme_id == programme_id &&
        other.specialization_id == specialization_id &&
        other.name == name &&
        other.code == code &&
        other.semester == semester &&
        other.type == type &&
        other.credit == credit &&
        other.elective == elective &&
        other.active == active &&
        other.student_id == student_id &&
        other.batch_id == batch_id &&
        other.subject_id == subject_id &&
        other.score == score &&
        other.entry_by == entry_by &&
        other.semester_exam_id == semester_exam_id;
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
        type.hashCode ^
        credit.hashCode ^
        elective.hashCode ^
        active.hashCode ^
        student_id.hashCode ^
        batch_id.hashCode ^
        subject_id.hashCode ^
        score.hashCode ^
        entry_by.hashCode ^
        semester_exam_id.hashCode;
  }
}
