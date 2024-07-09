// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AllAttendanceModel {
  int? id;
  int? internal_exam_id;
  int? student_id;
  int? semester;
  int? subject_id;
  int? attendance;
  String? total;
  String? month_year;
  String? status;
  int? entry_by;
  String? student_name;
  String? mzu_regn_no;
  String? subject_name;
  String? subject_code;
  String? programme_name;
  String? programme_code;
  String? specialization_name;
  AllAttendanceModel({
    this.id,
    this.internal_exam_id,
    this.student_id,
    this.semester,
    this.subject_id,
    this.attendance,
    this.total,
    this.month_year,
    this.status,
    this.entry_by,
    this.student_name,
    this.mzu_regn_no,
    this.subject_name,
    this.subject_code,
    this.programme_name,
    this.programme_code,
    this.specialization_name,
  });

  AllAttendanceModel copyWith({
    int? id,
    int? internal_exam_id,
    int? student_id,
    int? semester,
    int? subject_id,
    int? attendance,
    String? total,
    String? month_year,
    String? status,
    int? entry_by,
    String? student_name,
    String? mzu_regn_no,
    String? subject_name,
    String? subject_code,
    String? programme_name,
    String? programme_code,
    String? specialization_name,
  }) {
    return AllAttendanceModel(
      id: id ?? this.id,
      internal_exam_id: internal_exam_id ?? this.internal_exam_id,
      student_id: student_id ?? this.student_id,
      semester: semester ?? this.semester,
      subject_id: subject_id ?? this.subject_id,
      attendance: attendance ?? this.attendance,
      total: total ?? this.total,
      month_year: month_year ?? this.month_year,
      status: status ?? this.status,
      entry_by: entry_by ?? this.entry_by,
      student_name: student_name ?? this.student_name,
      mzu_regn_no: mzu_regn_no ?? this.mzu_regn_no,
      subject_name: subject_name ?? this.subject_name,
      subject_code: subject_code ?? this.subject_code,
      programme_name: programme_name ?? this.programme_name,
      programme_code: programme_code ?? this.programme_code,
      specialization_name: specialization_name ?? this.specialization_name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'internal_exam_id': internal_exam_id,
      'student_id': student_id,
      'semester': semester,
      'subject_id': subject_id,
      'attendance': attendance,
      'total': total,
      'month_year': month_year,
      'status': status,
      'entry_by': entry_by,
      'student_name': student_name,
      'mzu_regn_no': mzu_regn_no,
      'subject_name': subject_name,
      'subject_code': subject_code,
      'programme_name': programme_name,
      'programme_code': programme_code,
      'specialization_name': specialization_name,
    };
  }

  factory AllAttendanceModel.fromMap(Map<String, dynamic> map) {
    return AllAttendanceModel(
      id: map['id'] != null ? map['id'] as int : null,
      internal_exam_id: map['internal_exam_id'] != null
          ? map['internal_exam_id'] as int
          : null,
      student_id: map['student_id'] != null ? map['student_id'] as int : null,
      semester: map['semester'] != null ? map['semester'] as int : null,
      subject_id: map['subject_id'] != null ? map['subject_id'] as int : null,
      attendance: map['attendance'] != null ? map['attendance'] as int : null,
      total: map['total'] != null ? map['total'] as String : null,
      month_year:
          map['month_year'] != null ? map['month_year'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      entry_by: map['entry_by'] != null ? map['entry_by'] as int : null,
      student_name:
          map['student_name'] != null ? map['student_name'] as String : null,
      mzu_regn_no:
          map['mzu_regn_no'] != null ? map['mzu_regn_no'] as String : null,
      subject_name:
          map['subject_name'] != null ? map['subject_name'] as String : null,
      subject_code:
          map['subject_code'] != null ? map['subject_code'] as String : null,
      programme_name: map['programme_name'] != null
          ? map['programme_name'] as String
          : null,
      programme_code: map['programme_code'] != null
          ? map['programme_code'] as String
          : null,
      specialization_name: map['specialization_name'] != null
          ? map['specialization_name'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AllAttendanceModel.fromJson(String source) =>
      AllAttendanceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AllAttendanceModel(id: $id, internal_exam_id: $internal_exam_id, student_id: $student_id, semester: $semester, subject_id: $subject_id, attendance: $attendance, total: $total, month_year: $month_year, status: $status, entry_by: $entry_by, student_name: $student_name, mzu_regn_no: $mzu_regn_no, subject_name: $subject_name, subject_code: $subject_code, programme_name: $programme_name, programme_code: $programme_code, specialization_name: $specialization_name)';
  }

  @override
  bool operator ==(covariant AllAttendanceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.internal_exam_id == internal_exam_id &&
        other.student_id == student_id &&
        other.semester == semester &&
        other.subject_id == subject_id &&
        other.attendance == attendance &&
        other.total == total &&
        other.month_year == month_year &&
        other.status == status &&
        other.entry_by == entry_by &&
        other.student_name == student_name &&
        other.mzu_regn_no == mzu_regn_no &&
        other.subject_name == subject_name &&
        other.subject_code == subject_code &&
        other.programme_name == programme_name &&
        other.programme_code == programme_code &&
        other.specialization_name == specialization_name;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        internal_exam_id.hashCode ^
        student_id.hashCode ^
        semester.hashCode ^
        subject_id.hashCode ^
        attendance.hashCode ^
        total.hashCode ^
        month_year.hashCode ^
        status.hashCode ^
        entry_by.hashCode ^
        student_name.hashCode ^
        mzu_regn_no.hashCode ^
        subject_name.hashCode ^
        subject_code.hashCode ^
        programme_name.hashCode ^
        programme_code.hashCode ^
        specialization_name.hashCode;
  }
}
