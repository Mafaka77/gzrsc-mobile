// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MonthModel {
  int? id;
  String? month;
  MonthModel({
    this.id,
    this.month,
  });

  MonthModel copyWith({
    int? id,
    String? month,
  }) {
    return MonthModel(
      id: id ?? this.id,
      month: month ?? this.month,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'month': month,
    };
  }

  bool isEqual(MonthModel model) {
    return id == model.id;
  }

  factory MonthModel.fromMap(Map<String, dynamic> map) {
    return MonthModel(
      id: map['id'] != null ? map['id'] as int : null,
      month: map['month'] != null ? map['month'] as String : null,
    );
  }
  static List<MonthModel> fromJsonList(List list) {
    return list.map((e) => MonthModel.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory MonthModel.fromJson(String source) =>
      MonthModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => '$month';

  @override
  bool operator ==(covariant MonthModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.month == month;
  }

  @override
  int get hashCode => id.hashCode ^ month.hashCode;
}
