// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  int? id;
  String? name;
  String? reg_no;
  String? email;
  String? contact;
  int? department_id;
  UserModel({
    this.id,
    this.name,
    this.reg_no,
    this.email,
    this.contact,
    this.department_id,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? reg_no,
    String? email,
    String? contact,
    int? department_id,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      reg_no: reg_no ?? this.reg_no,
      email: email ?? this.email,
      contact: contact ?? this.contact,
      department_id: department_id ?? this.department_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'reg_no': reg_no,
      'email': email,
      'contact': contact,
      'department_id': department_id,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      reg_no: map['reg_no'] != null ? map['reg_no'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      contact: map['contact'] != null ? map['contact'] as String : null,
      department_id:
          map['department_id'] != null ? map['department_id'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, reg_no: $reg_no, email: $email, contact: $contact, department_id: $department_id)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.reg_no == reg_no &&
        other.email == email &&
        other.contact == contact &&
        other.department_id == department_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        reg_no.hashCode ^
        email.hashCode ^
        contact.hashCode ^
        department_id.hashCode;
  }
}
