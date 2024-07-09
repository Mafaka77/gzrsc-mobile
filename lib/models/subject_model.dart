// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SubjectModel {
  int? id;
  int? programme_id;
  String? name;
  String? code;
  SubjectModel({
    this.id,
    this.programme_id,
    this.name,
    this.code,
  });

  SubjectModel copyWith({
    int? id,
    int? programme_id,
    String? name,
    String? code,
  }) {
    return SubjectModel(
      id: id ?? this.id,
      programme_id: programme_id ?? this.programme_id,
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'programme_id': programme_id,
      'name': name,
      'code': code,
    };
  }

  factory SubjectModel.fromMap(Map<String, dynamic> map) {
    return SubjectModel(
      id: map['id'] != null ? map['id'] as int : null,
      programme_id:
          map['programme_id'] != null ? map['programme_id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
    );
  }
  static List<SubjectModel> fromJsonList(List list) {
    return list.map((e) => SubjectModel.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory SubjectModel.fromJson(String source) =>
      SubjectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return ' $name';
  }

  bool isEqual(SubjectModel model) {
    return id == model.id;
  }

  @override
  bool operator ==(covariant SubjectModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.programme_id == programme_id &&
        other.name == name &&
        other.code == code;
  }

  @override
  int get hashCode {
    return id.hashCode ^ programme_id.hashCode ^ name.hashCode ^ code.hashCode;
  }
}
