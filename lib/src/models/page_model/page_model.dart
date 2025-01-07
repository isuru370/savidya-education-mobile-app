import 'package:equatable/equatable.dart';

class PageModel extends Equatable {
  final int? id;
  final String? pageName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const PageModel({
    this.id,
    this.pageName,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id, pageName, createdAt, updatedAt];

  PageModel copyWith({
    int? id,
    String? pageName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PageModel(
      id: id ?? this.id,
      pageName: pageName ?? this.pageName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'page': pageName,
      };

  factory PageModel.fromJson(Map<String, dynamic> json) {
    return PageModel(
      id: json['id'] is String ? int.parse(json['id']) : json['id'] as int,
      pageName: json['page'] as String?,
      createdAt:
          json['created_at'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updated_at'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}
