import 'package:equatable/equatable.dart';

class ClassHasCategoryModelClass extends Equatable {
  final int? classHasCatId;
  final double? classFees;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? categoryId;
  final String? categoryName;
  final int? classId;
  final String? className;
  final int? teacherId;
  final String? fullName;
  final String? initialName;
  final int? subjectId;
  final String? subjectName;
  final int? gradeId;
  final String? gradeName;

  const ClassHasCategoryModelClass({
    this.classHasCatId,
    this.classFees,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
    this.categoryName,
    this.classId,
    this.className,
    this.teacherId,
    this.fullName,
    this.initialName,
    this.subjectId,
    this.subjectName,
    this.gradeId,
    this.gradeName,
  });

  @override
  List<Object?> get props => [
        classHasCatId,
        classFees,
        createdAt,
        updatedAt,
        categoryId,
        categoryName,
        classId,
        className,
        teacherId,
        fullName,
        initialName,
        subjectId,
        subjectName,
        gradeId,
        gradeName,
      ];

  ClassHasCategoryModelClass copyWith({
    int? classHasCatId,
    double? classFees,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? categoryId,
    String? categoryName,
    int? classId,
    String? className,
    int? teacherId,
    String? fullName,
    String? initialName,
    int? subjectId,
    String? subjectName,
    int? gradeId,
    String? gradeName,
  }) {
    return ClassHasCategoryModelClass(
      classHasCatId: classHasCatId ?? this.classHasCatId,
      classFees: classFees ?? this.classFees,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      classId: classId ?? this.classId,
      className: className ?? this.className,
      teacherId: teacherId ?? this.teacherId,
      fullName: fullName ?? this.fullName,
      initialName: initialName ?? this.initialName,
      subjectId: subjectId ?? this.subjectId,
      subjectName: subjectName ?? this.subjectName,
      gradeId: gradeId ?? this.gradeId,
      gradeName: gradeName ?? this.gradeName,
    );
  }

  factory ClassHasCategoryModelClass.fromJson(Map<String, dynamic> json) {
    return ClassHasCategoryModelClass(
      classHasCatId: _parseInt(json['classHasCatId']),
      classFees: _parseDouble(json['classFees']),
      createdAt: _parseDateTime(json['createdAt']),
      updatedAt: _parseDateTime(json['updatedAt']),
      categoryId: _parseInt(json['categoryId']),
      categoryName: json['categoryName'] ?? "",
      classId: _parseInt(json['classId']),
      className: json['className'] ?? "",
      teacherId: _parseInt(json['teacherId']),
      fullName: json['fullName'] ?? "",
      initialName: json['initialName'] ?? "",
      subjectId: _parseInt(json['subjectId']),
      subjectName: json['subjectName'] ?? "",
      gradeId: _parseInt(json['gradeId']),
      gradeName: json['gradeName'] ?? "",
    );
  }

  factory ClassHasCategoryModelClass.allFromJson(Map<String, dynamic> json) {
    return ClassHasCategoryModelClass(
      classHasCatId: _parseInt(json['classHasCatId']),
      classFees: _parseDouble(json['classFees']),
      createdAt: _parseDateTime(json['createdAt']),
      updatedAt: _parseDateTime(json['updatedAt']),
      categoryId: _parseInt(json['categoryId']),
      categoryName: json['categoryName'] ?? "",
      classId: _parseInt(json['classId']),
      className: json['className'] ?? "",
      teacherId: _parseInt(json['teacherId']),
      fullName: json['fullName'] ?? "",
      initialName: json['initialName'] ?? "",
      subjectId: _parseInt(json['subjectId']),
      subjectName: json['subjectName'] ?? "",
      gradeId: _parseInt(json['gradeId']),
      gradeName: json['gradeName'] ?? "",
    );
  }

  // Helper methods for parsing
  static int? _parseInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value);
    }
    return null;
  }

  static double? _parseDouble(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value is String) {
      return DateTime.tryParse(value);
    }
    return null;
  }
}
