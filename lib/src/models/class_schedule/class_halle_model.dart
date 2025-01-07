import 'package:equatable/equatable.dart';

class ClassHalleModelClass extends Equatable {
  final int? id;
  final String? hallId;
  final String? hallName;
  final DateTime? createdAt;
  final DateTime? updateAt;

  // Constructor
  const ClassHalleModelClass({
    this.id,
    this.hallId,
    this.hallName,
    this.createdAt,
    this.updateAt,
  });

  @override
  List<Object?> get props => [id, hallId, hallName, createdAt, updateAt];

  factory ClassHalleModelClass.fromJson(Map<String, dynamic> json) {
    return ClassHalleModelClass(
      id: json["id"] is String ? int.parse(json["id"]) : json["id"] as int?,
      hallId: json["hall_id"] as String?,
      hallName: json["hall_name"] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updateAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }
}
