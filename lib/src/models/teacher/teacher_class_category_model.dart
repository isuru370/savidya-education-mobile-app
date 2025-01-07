import 'package:equatable/equatable.dart';

class TeacherClassCategoryModel extends Equatable {
  final int classHasCatId;
  final int studentClassesId;
  final int classCatId;
  final double classFees;
  final String categoryName;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TeacherClassCategoryModel({
    required this.classHasCatId,
    required this.studentClassesId,
    required this.classCatId,
    required this.classFees,
    required this.categoryName,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        classHasCatId,
        studentClassesId,
        classCatId,
        classFees,
        categoryName,
        createdAt,
        updatedAt,
      ];

  // Factory constructor to create an instance from JSON
  factory TeacherClassCategoryModel.fromJson(Map<String, dynamic> json) {
    return TeacherClassCategoryModel(
      classHasCatId: int.tryParse(json['class_has_cat_id'].toString()) ?? 0,
      studentClassesId:
          int.tryParse(json['student_classes_id'].toString()) ?? 0,
      classCatId: int.tryParse(json['class_cat_id'].toString()) ?? 0,
      classFees: double.tryParse(json['class_fees'].toString()) ?? 0.0,
      categoryName: json['category_name'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime(1970),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime(1970),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'class_has_cat_id': classHasCatId,
      'student_classes_id': studentClassesId,
      'class_cat_id': classCatId,
      'class_fees': classFees,
      'category_name': categoryName,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // CopyWith method for immutability
  TeacherClassCategoryModel copyWith({
    int? classHasCatId,
    int? studentClassesId,
    int? classCatId,
    double? classFees,
    String? categoryName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TeacherClassCategoryModel(
      classHasCatId: classHasCatId ?? this.classHasCatId,
      studentClassesId: studentClassesId ?? this.studentClassesId,
      classCatId: classCatId ?? this.classCatId,
      classFees: classFees ?? this.classFees,
      categoryName: categoryName ?? this.categoryName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
