import 'package:equatable/equatable.dart';

class UserTypeModelClass extends Equatable {
  final int? id;
  final String? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserTypeModelClass({
    this.id,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        createdAt,
        updatedAt,
      ];

  factory UserTypeModelClass.fromJson(Map<String, dynamic> json) {
    return UserTypeModelClass(
      id: json["id"] is int ? json["id"] : int.tryParse(json["id"].toString()), // Handle int and string cases
      type: json["type"] as String?,
      createdAt: json["created_at"] != null ? DateTime.tryParse(json["created_at"].toString()) : null, // Safe parsing
      updatedAt: json["updated_at"] != null ? DateTime.tryParse(json["updated_at"].toString()) : null, // Safe parsing
    );
  }
}
