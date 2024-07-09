// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lms/models/department_model.dart';

class FacultyModel {
  int? id;
  String? name;
  String? category;
  String? reg_no;
  String? email;
  int? contact;
  String? status;
  int? department_id;
  DepartmentModel? departmentModel;
  FacultyModel({
    this.id,
    this.name,
    this.category,
    this.reg_no,
    this.email,
    this.contact,
    this.status,
    this.department_id,
    this.departmentModel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'category': category,
      'reg_no': reg_no,
      'email': email,
      'contact': contact,
      'status': status,
      'department_id': department_id,
      'departmentModel': departmentModel?.toMap(),
    };
  }

  factory FacultyModel.fromMap(Map<String, dynamic> map) {
    return FacultyModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      reg_no: map['reg_no'] != null ? map['reg_no'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      contact: map['contact'] != null ? map['contact'] as int : null,
      status: map['status'] != null ? map['status'] as String : null,
      department_id:
          map['department_id'] != null ? map['department_id'] as int : null,
      departmentModel: map['department'] != null
          ? DepartmentModel.fromMap(map['department'] as Map<String, dynamic>)
          : null,
    );
  }
  static List<FacultyModel> fromJsonList(List list) {
    return list.map((e) => FacultyModel.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory FacultyModel.fromJson(String source) =>
      FacultyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return '$name (${departmentModel!.name})';
  }

  bool isEqual(FacultyModel model) {
    return id == model.id;
  }
}
