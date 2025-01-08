import 'package:equatable/equatable.dart';

class StudentHasClassModelClass extends Equatable {
  final int? studentId;
  final String? studentCusId;
  final String? fullName;
  final String? initialName;
  final int? classHasCatId;
  final double? classFees;
  final int? categoryId;
  final String? categoryName;
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

  const StudentHasClassModelClass({
    this.studentId,
    this.studentCusId,
    this.fullName,
    this.initialName,
    this.classHasCatId,
    this.classFees,
    this.categoryId,
    this.categoryName,
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

  StudentHasClassModelClass copyWith({
    int? studentId,
    String? studentCusId,
    String? fullName,
    String? initialName,
    int? classHasCatId,
    double? classFees,
    int? categoryId,
    String? categoryName,
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
    return StudentHasClassModelClass(
      studentId: studentId ?? this.studentId,
      studentCusId: studentCusId ?? this.studentCusId,
      fullName: fullName ?? this.fullName,
      initialName: initialName ?? this.initialName,
      classHasCatId: classHasCatId ?? this.classHasCatId,
      classFees: classFees ?? this.classFees,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
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

  factory StudentHasClassModelClass.fromJson(Map<String, dynamic> json) {
    return StudentHasClassModelClass(
      studentId: _parseInt(json['studentId']),
      studentCusId: json['studentCusId'] as String?,
      fullName: json['fullName'] as String?,
      initialName: json['initialName'] as String?,
      classHasCatId: _parseInt(json['classHasCatId']),
      classFees: _parseDouble(json['classFees']),
      categoryId: _parseInt(json['categoryId']),
      categoryName: json['categoryName'] as String?,
      className: json['className'] as String?,
      classDayName: json['classDayName'] as String?,
      teacherId: _parseInt(json['teacherId']),
      teacherCusId: json['teacherCusId'] as String?,
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

  static int? _parseInt(dynamic value) {
    if (value is int) {
      return value; // Already an integer
    } else if (value is String) {
      return int.tryParse(
          value); // Attempt to parse as int, return null if parsing fails
    }
    return null; // Return null if value is neither an int nor a string
  }

  static double? _parseDouble(dynamic value) {
    if (value is double) {
      return value; // Already a double
    } else if (value is String) {
      return double.tryParse(
          value); // Attempt to parse as double, return null if parsing fails
    }
    return null; // Return null if value is neither a double nor a string
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'studentCusId': studentCusId,
      'fullName': fullName,
      'initialName': initialName,
      'classHasCatId': classHasCatId,
      'classFees': classFees,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'className': className,
      'classDayName': classDayName,
      'teacherId': teacherId,
      'teacherCusId': teacherCusId,
      'teacherFullName': teacherFullName,
      'teacherInitialName': teacherInitialName,
      'subjectId': subjectId,
      'subjectName': subjectName,
      'gradeId': gradeId,
      'gradeName': gradeName,
      'studentHasClassesId': studentHasClassesId,
      'createAt': createAt?.toIso8601String(),
      'updateAt': updateAt?.toIso8601String(),
    };
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
