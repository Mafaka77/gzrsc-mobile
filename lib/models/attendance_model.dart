// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AttendanceModel {
  int? internal_exam_id;
  int? student_id;
  int? batch_id;
  String? semester;
  int? subject_id;
  int? attendance;
  int? total;
  String? month;
  String? year;
  String? status;
  int? entry_by;
  String? name;
  String? mzu_regn_no;

  AttendanceModel({
    this.internal_exam_id,
    this.student_id,
    this.batch_id,
    this.semester,
    this.subject_id,
    this.attendance,
    this.total,
    this.month,
    this.year,
    this.status,
    this.entry_by,
    this.name,
    this.mzu_regn_no,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'internal_exam_id': internal_exam_id,
      'student_id': student_id,
      'batch_id': batch_id,
      'semester': semester,
      'subject_id': subject_id,
      'attendance': attendance,
      'total': total,
      'month': month,
      'year': year,
      'status': status,
      'entry_by': entry_by,
      'name': name,
      'mzu_regn_no': mzu_regn_no,
    };
  }

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      internal_exam_id: map['internal_exam_id'] != null
          ? map['internal_exam_id'] as int
          : null,
      student_id: map['student_id'] != null ? map['student_id'] as int : null,
      batch_id: map['batch_id'] != null ? map['batch_id'] as int : null,
      semester: map['semester'] != null ? map['semester'] as String : null,
      subject_id: map['subject_id'] != null ? map['subject_id'] as int : null,
      attendance: map['attendance'] != null ? map['attendance'] as int : null,
      total: map['total'] != null ? map['total'] as int : null,
      month: map['month'] != null ? map['month'] as String : null,
      year: map['year'] != null ? map['year'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      entry_by: map['entry_by'] != null ? map['entry_by'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      mzu_regn_no:
          map['mzu_regn_no'] != null ? map['mzu_regn_no'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceModel.fromJson(String source) =>
      AttendanceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AttendanceModel(internal_exam_id: $internal_exam_id, student_id: $student_id, batch_id: $batch_id, semester: $semester, subject_id: $subject_id, attendance: $attendance, total: $total, month: $month, year: $year, status: $status, entry_by: $entry_by, name: $name, mzu_regn_no: $mzu_regn_no)';
  }

  @override
  bool operator ==(covariant AttendanceModel other) {
    if (identical(this, other)) return true;

    return other.internal_exam_id == internal_exam_id &&
        other.student_id == student_id &&
        other.batch_id == batch_id &&
        other.semester == semester &&
        other.subject_id == subject_id &&
        other.attendance == attendance &&
        other.total == total &&
        other.month == month &&
        other.year == year &&
        other.status == status &&
        other.entry_by == entry_by &&
        other.name == name &&
        other.mzu_regn_no == mzu_regn_no;
  }

  @override
  int get hashCode {
    return internal_exam_id.hashCode ^
        student_id.hashCode ^
        batch_id.hashCode ^
        semester.hashCode ^
        subject_id.hashCode ^
        attendance.hashCode ^
        total.hashCode ^
        month.hashCode ^
        year.hashCode ^
        status.hashCode ^
        entry_by.hashCode ^
        name.hashCode ^
        mzu_regn_no.hashCode;
  }
}
