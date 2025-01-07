import 'package:equatable/equatable.dart';

class ClassCategoryModelClass extends Equatable {
  final int? categoryId;
  final String? categoryName;
  final DateTime? createAt;
  final DateTime? updateAt;

  const ClassCategoryModelClass({
    this.categoryId,
    this.categoryName,
    this.createAt,
    this.updateAt,
  });

  ClassCategoryModelClass copyWith({
    int? categoryId,
    String? categoryName,
    DateTime? createAt,
    DateTime? updateAt,
  }) {
    return ClassCategoryModelClass(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  factory ClassCategoryModelClass.fromJson(Map<String, dynamic> json) {
    return ClassCategoryModelClass(
      categoryId:
          json['id'] is String ? int.parse(json['id']) : json['id'] as int?,
      categoryName: json['category_name'] as String?,
      createAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updateAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
    };
  }

  @override
  List<Object?> get props => [categoryId, categoryName, createAt, updateAt];
}
