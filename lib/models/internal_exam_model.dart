// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class InternalExamModel {
  int? id;
  String? name;
  String? code;
  String? status;
  InternalExamModel({
    this.id,
    this.name,
    this.code,
    this.status,
  });

  InternalExamModel copyWith({
    int? id,
    String? name,
    String? code,
    String? status,
  }) {
    return InternalExamModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'code': code,
      'status': status,
    };
  }

  factory InternalExamModel.fromMap(Map<String, dynamic> map) {
    return InternalExamModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }
  static List<InternalExamModel> fromJsonList(List list) {
    return list.map((e) => InternalExamModel.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory InternalExamModel.fromJson(String source) =>
      InternalExamModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return ' $name';
  }

  bool isEqual(InternalExamModel model) {
    return id == model.id;
  }

  @override
  bool operator ==(covariant InternalExamModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.code == code &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ code.hashCode ^ status.hashCode;
  }
}
