// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProgramModel {
  int? id;
  String? name;
  int? course_id;
  String? code;
  ProgramModel({
    this.id,
    this.name,
    this.course_id,
    this.code,
  });

  ProgramModel copyWith({
    int? id,
    String? name,
    int? course_id,
    String? code,
  }) {
    return ProgramModel(
      id: id ?? this.id,
      name: name ?? this.name,
      course_id: course_id ?? this.course_id,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'course_id': course_id,
      'code': code,
    };
  }

  factory ProgramModel.fromMap(Map<String, dynamic> map) {
    return ProgramModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      course_id: map['course_id'] != null ? map['course_id'] as int : null,
      code: map['code'] != null ? map['code'] as String : null,
    );
  }
  static List<ProgramModel> fromJsonList(List list) {
    return list.map((e) => ProgramModel.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory ProgramModel.fromJson(String source) =>
      ProgramModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProgramModel(id: $id, name: $name, course_id: $course_id, code: $code)';
  }

  bool isEqual(ProgramModel model) {
    return id == model.id;
  }

  @override
  bool operator ==(covariant ProgramModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.course_id == course_id &&
        other.code == code;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ course_id.hashCode ^ code.hashCode;
  }
}
