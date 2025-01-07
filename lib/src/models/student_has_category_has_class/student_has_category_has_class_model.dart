import 'package:equatable/equatable.dart';

class StudentHasCategoryHasClassModelClass extends Equatable {
  final int? studentId;
  final String? studentCusId;
  final int? studentClassFreeCard;
  final String? fullName;
  final String? initialName;
  final int? classHasCatId;
  final double? classFees;
  final int? categoryId;
  final String? categoryName;
  final int? classId;
  final String? className;
  final String? classDayName;
  final int? teacherId;
  final String? teacherCusId;
  final String? teacherFullName;
  final String? teacherInitialName;
  final int? subjectId;
  final String? subjectName;
  final int? gradeId;
  final String? gradeName;
  final int? studentHasClassesId;
  final DateTime? createAt;
  final DateTime? updateAt;

  const StudentHasCategoryHasClassModelClass({
    this.studentId,
    this.studentCusId,
    this.studentClassFreeCard,
    this.fullName,
    this.initialName,
    this.classHasCatId,
    this.classFees,
    this.categoryId,
    this.categoryName,
    this.classId,
    this.className,
    this.classDayName,
    this.teacherId,
    this.teacherCusId,
    this.teacherFullName,
    this.teacherInitialName,
    this.subjectId,
    this.subjectName,
    this.gradeId,
    this.gradeName,
    this.studentHasClassesId,
    this.createAt,
    this.updateAt,
  });

  /// Factory constructor for creating a new instance from JSON.
  factory StudentHasCategoryHasClassModelClass.fromJson(
      Map<String, dynamic> json) {
    return StudentHasCategoryHasClassModelClass(
      studentId: _parseInt(json['studentId']),
      studentCusId: json['studentCusId']?.toString(),
      studentClassFreeCard: _parseInt(json['classFreeCard']),
      fullName: json['fullName'] as String?,
      initialName: json['initialName'] as String?,
      classHasCatId: _parseInt(json['classHasCatId']),
      classFees: _parseDouble(json['classFees']),
      categoryId: _parseInt(json['categoryId']),
      categoryName: json['categoryName'] as String?,
      classId: _parseInt(json['classId']),
      className: json['className'] as String?,
      classDayName: json['classDayName'] as String?,
      teacherId: _parseInt(json['teacherId']),
      teacherCusId: json['teacherCusId']?.toString(),
      teacherFullName: json['teacherFullName'] as String?,
      teacherInitialName: json['teacherInitialName'] as String?,
      subjectId: _parseInt(json['subjectId']),
      subjectName: json['subjectName'] as String?,
      gradeId: _parseInt(json['gradeId']),
      gradeName: json['gradeName'] as String?,
      studentHasClassesId: _parseInt(json['studentHasClassesId']),
      createAt:
          json['createAt'] != null ? DateTime.tryParse(json['createAt']) : null,
      updateAt:
          json['updateAt'] != null ? DateTime.tryParse(json['updateAt']) : null,
    );
  }

  /// Method for generating a JSON map for specific fields.
  Map<String, dynamic> changeJson() {
    return {
      "student_student_student_classes_id": studentHasClassesId,
      "student_classes_id": classId,
      "class_category_has_student_class_id": classHasCatId,
      "is_free_card": studentClassFreeCard,
    };
  }

  Map<String, dynamic> deleteJson() {
    return {
      "student_student_student_classes_id": studentHasClassesId,
    };
  }

  /// copyWith method for creating modified copies of an instance.
  StudentHasCategoryHasClassModelClass copyWith({
    int? studentId,
    String? studentCusId,
    int? studentClassFreeCard,
    String? fullName,
    String? initialName,
    int? classHasCatId,
    double? classFees,
    int? categoryId,
    String? categoryName,
    int? classId,
    String? className,
    String? classDayName,
    int? teacherId,
    String? teacherCusId,
    String? teacherFullName,
    String? teacherInitialName,
    int? subjectId,
    String? subjectName,
    int? gradeId,
    String? gradeName,
    int? studentHasClassesId,
    DateTime? createAt,
    DateTime? updateAt,
  }) {
    return StudentHasCategoryHasClassModelClass(
      studentId: studentId ?? this.studentId,
      studentCusId: studentCusId ?? this.studentCusId,
      studentClassFreeCard: studentClassFreeCard ?? this.studentClassFreeCard,
      fullName: fullName ?? this.fullName,
      initialName: initialName ?? this.initialName,
      classHasCatId: classHasCatId ?? this.classHasCatId,
      classFees: classFees ?? this.classFees,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      classId: classId ?? this.classId,
      className: className ?? this.className,
      classDayName: classDayName ?? this.classDayName,
      teacherId: teacherId ?? this.teacherId,
      teacherCusId: teacherCusId ?? this.teacherCusId,
      teacherFullName: teacherFullName ?? this.teacherFullName,
      teacherInitialName: teacherInitialName ?? this.teacherInitialName,
      subjectId: subjectId ?? this.subjectId,
      subjectName: subjectName ?? this.subjectName,
      gradeId: gradeId ?? this.gradeId,
      gradeName: gradeName ?? this.gradeName,
      studentHasClassesId: studentHasClassesId ?? this.studentHasClassesId,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  /// Helper methods for parsing nullable int and double values with error handling.
  static int? _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  static double? _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is String) return double.tryParse(value);
    return null;
  }

  @override
  List<Object?> get props => [
        studentId,
        studentCusId,
        fullName,
        initialName,
        classHasCatId,
        classFees,
        categoryId,
        categoryName,
        classId,
        className,
        classDayName,
        teacherId,
        teacherCusId,
        teacherFullName,
        teacherInitialName,
        subjectId,
        subjectName,
        gradeId,
        gradeName,
        studentHasClassesId,
        createAt,
        updateAt,
      ];
}
