// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lms/models/repository_category_model.dart';
import 'package:lms/models/submitted_by_model.dart';

class RepositoriesModel {
  int? id;
  int? repository_category_id;
  SubmittedByModel submittedByModel;
  RepositoryCategoryModel repositoryCategoryModel;
  String? title;
  String? description;
  String? attachments;
  String? date;
  String? status;
  RepositoriesModel({
    this.id,
    this.repository_category_id,
    required this.submittedByModel,
    required this.repositoryCategoryModel,
    this.title,
    this.description,
    this.attachments,
    this.date,
    this.status,
  });

  factory RepositoriesModel.fromMap(Map<String, dynamic> map) {
    return RepositoriesModel(
      id: map['id'] != null ? map['id'] as int : null,
      repository_category_id: map['repository_category_id'] != null
          ? map['repository_category_id'] as int
          : null,
      submittedByModel:
          SubmittedByModel.fromMap(map['submitted_by'] as Map<String, dynamic>),
      repositoryCategoryModel: RepositoryCategoryModel.fromMap(
          map['repository_category'] as Map<String, dynamic>),
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      attachments:
          map['attachments'] != null ? map['attachments'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }
  static List<RepositoriesModel> fromJsonList(List list) {
    return list.map((e) => RepositoriesModel.fromMap(e)).toList();
  }

  RepositoriesModel copyWith({
    int? id,
    int? repository_category_id,
    SubmittedByModel? submittedByModel,
    RepositoryCategoryModel? repositoryCategoryModel,
    String? title,
    String? description,
    String? attachments,
    String? date,
    String? status,
  }) {
    return RepositoriesModel(
      id: id ?? this.id,
      repository_category_id:
          repository_category_id ?? this.repository_category_id,
      submittedByModel: submittedByModel ?? this.submittedByModel,
      repositoryCategoryModel:
          repositoryCategoryModel ?? this.repositoryCategoryModel,
      title: title ?? this.title,
      description: description ?? this.description,
      attachments: attachments ?? this.attachments,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'repository_category_id': repository_category_id,
      'submittedByModel': submittedByModel.toMap(),
      'repositoryCategoryModel': repositoryCategoryModel.toMap(),
      'title': title,
      'description': description,
      'attachments': attachments,
      'date': date,
      'status': status,
    };
  }

  String toJson() => json.encode(toMap());

  factory RepositoriesModel.fromJson(String source) =>
      RepositoriesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RepositoriesModel(id: $id, repository_category_id: $repository_category_id, submittedByModel: $submittedByModel, repositoryCategoryModel: $repositoryCategoryModel, title: $title, description: $description, attachments: $attachments, date: $date, status: $status)';
  }

  @override
  bool operator ==(covariant RepositoriesModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.repository_category_id == repository_category_id &&
        other.submittedByModel == submittedByModel &&
        other.repositoryCategoryModel == repositoryCategoryModel &&
        other.title == title &&
        other.description == description &&
        other.attachments == attachments &&
        other.date == date &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        repository_category_id.hashCode ^
        submittedByModel.hashCode ^
        repositoryCategoryModel.hashCode ^
        title.hashCode ^
        description.hashCode ^
        attachments.hashCode ^
        date.hashCode ^
        status.hashCode;
  }
}
