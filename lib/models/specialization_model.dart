// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lms/models/program_model.dart';

class SpecializationModel {
  int? id;
  int? programme_id;
  int? department_id;
  String? name;
  late ProgramModel programModel;
  SpecializationModel({
    this.id,
    this.programme_id,
    this.department_id,
    this.name,
    required this.programModel,
  });

  SpecializationModel copyWith({
    int? id,
    int? programme_id,
    int? department_id,
    String? name,
    ProgramModel? programModel,
  }) {
    return SpecializationModel(
      id: id ?? this.id,
      programme_id: programme_id ?? this.programme_id,
      department_id: department_id ?? this.department_id,
      name: name ?? this.name,
      programModel: programModel ?? this.programModel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'programme_id': programme_id,
      'department_id': department_id,
      'name': name,
      'programModel': programModel.toMap(),
    };
  }

  factory SpecializationModel.fromMap(Map<String, dynamic> map) {
    return SpecializationModel(
      id: map['id'] != null ? map['id'] as int : null,
      programme_id:
          map['programme_id'] != null ? map['programme_id'] as int : null,
      department_id:
          map['department_id'] != null ? map['department_id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      programModel:
          ProgramModel.fromMap(map['programme'] as Map<String, dynamic>),
    );
  }
  static List<SpecializationModel> fromJsonList(List list) {
    return list.map((e) => SpecializationModel.fromMap(e)).toList();
  }

  bool isEqual(SpecializationModel model) {
    return id == model.id;
  }

  String toJson() => json.encode(toMap());

  factory SpecializationModel.fromJson(String source) =>
      SpecializationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return '${programModel.code} - $name';
  }

  @override
  bool operator ==(covariant SpecializationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.programme_id == programme_id &&
        other.department_id == department_id &&
        other.name == name &&
        other.programModel == programModel;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        programme_id.hashCode ^
        department_id.hashCode ^
        name.hashCode ^
        programModel.hashCode;
  }
}
