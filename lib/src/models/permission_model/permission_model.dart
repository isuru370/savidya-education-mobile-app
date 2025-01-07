import 'package:equatable/equatable.dart';

class PermissionModel extends Equatable {
  final int? id;
  final int? userTypeId;
  final int? pageId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const PermissionModel({
    this.id,
    this.userTypeId,
    this.pageId,
    this.createdAt,
    this.updatedAt,
  });

  factory PermissionModel.fromJson(Map<String, dynamic> json) {
    return PermissionModel(
      id: json['id'] as int?,
      userTypeId: json['user_type_id'] as int?,
      pageId: json['page_id'] as int?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_type_id': userTypeId,
      'page_id': pageId,
    };
  }

  // Override props for Equatable
  @override
  List<Object?> get props => [id, userTypeId, pageId, createdAt, updatedAt];
}
