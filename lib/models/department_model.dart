// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DepartmentModel {
  int? id;
  String? name;
  String? code;
  String? status;
  DepartmentModel({
    this.id,
    this.name,
    this.code,
    this.status,
  });

  DepartmentModel copyWith({
    int? id,
    String? name,
    String? code,
    String? status,
  }) {
    return DepartmentModel(
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

  factory DepartmentModel.fromMap(Map<String, dynamic> map) {
    return DepartmentModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DepartmentModel.fromJson(String source) =>
      DepartmentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DepartmentModel(id: $id, name: $name, code: $code, status: $status)';
  }

  @override
  bool operator ==(covariant DepartmentModel other) {
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
