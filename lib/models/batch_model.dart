// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BatchModel {
  int? id;
  int? course_id;
  int? current_semester;
  String? status;
  String? start_year;
  String? end_year;
  String? seat;
  BatchModel({
    this.id,
    this.course_id,
    this.current_semester,
    this.status,
    this.start_year,
    this.end_year,
    this.seat,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'course_id': course_id,
      'current_semester': current_semester,
      'status': status,
      'start_year': start_year,
      'end_year': end_year,
      'seat': seat,
    };
  }

  factory BatchModel.fromMap(Map<String, dynamic> map) {
    return BatchModel(
      id: map['id'] != null ? map['id'] as int : null,
      course_id: map['course_id'] != null ? map['course_id'] as int : null,
      current_semester: map['current_semester'] != null
          ? map['current_semester'] as int
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      start_year:
          map['start_year'] != null ? map['start_year'] as String : null,
      end_year: map['end_year'] != null ? map['end_year'] as String : null,
      seat: map['seat'] != null ? map['seat'] as String : null,
    );
  }
  static List<BatchModel> fromJsonList(List list) {
    return list.map((e) => BatchModel.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory BatchModel.fromJson(String source) =>
      BatchModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return '$start_year-$end_year($current_semester)';
  }

  bool isEqual(BatchModel model) {
    return id == model.id;
  }

  @override
  bool operator ==(covariant BatchModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.course_id == course_id &&
        other.current_semester == current_semester &&
        other.status == status &&
        other.start_year == start_year &&
        other.end_year == end_year &&
        other.seat == seat;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        course_id.hashCode ^
        current_semester.hashCode ^
        status.hashCode ^
        start_year.hashCode ^
        end_year.hashCode ^
        seat.hashCode;
  }
}
