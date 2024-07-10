// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SubmittedByModel {
  int? id;
  String? name;
  SubmittedByModel({
    this.id,
    this.name,
  });

  SubmittedByModel copyWith({
    int? id,
    String? name,
  }) {
    return SubmittedByModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory SubmittedByModel.fromMap(Map<String, dynamic> map) {
    return SubmittedByModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubmittedByModel.fromJson(String source) =>
      SubmittedByModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SubmittedByModel(id: $id, name: $name)';

  @override
  bool operator ==(covariant SubmittedByModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
