// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RepositoryCategoryModel {
  int? id;
  String? name;
  String? status;
  RepositoryCategoryModel({
    this.id,
    this.name,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'status': status,
    };
  }

  factory RepositoryCategoryModel.fromMap(Map<String, dynamic> map) {
    return RepositoryCategoryModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }
  static List<RepositoryCategoryModel> fromJsonList(List list) {
    return list.map((e) => RepositoryCategoryModel.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory RepositoryCategoryModel.fromJson(String source) =>
      RepositoryCategoryModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RepositoryCategoryModel(id: $id, name: $name, status: $status)';

  @override
  bool operator ==(covariant RepositoryCategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.status == status;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ status.hashCode;
}
