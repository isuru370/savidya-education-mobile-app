import 'package:equatable/equatable.dart';

class ClassScheduleModelClass extends Equatable {
  final int? id;
  final String? className;
  final int? isActive;
  final int? isOngoing;
  final int? teacherId;
  final String? teacherFullName;
  final String? teacherInitialName;
  final int? subjectId;
  final String? subjectName;
  final int? gradeId;
  final String? gradeName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ClassScheduleModelClass({
    this.id,
    this.className,
    this.isActive,
    this.isOngoing,
    this.teacherId,
    this.subjectId,
    this.gradeId,
    this.createdAt,
    this.updatedAt,
    this.teacherFullName,
    this.teacherInitialName,
    this.subjectName,
    this.gradeName,
  });

  @override
  List<Object?> get props => [
        id,
        className,
        isActive,
        isOngoing,
        teacherId,
        subjectId,
        gradeId,
        createdAt,
        updatedAt,
        teacherFullName,
        teacherInitialName,
        subjectName,
        gradeName,
      ];

  // copyWith method
  ClassScheduleModelClass copyWith({
    int? id,
    String? className,
    int? isActive,
    int? isOngoing,
    int? teacherId,
    int? subjectId,
    int? gradeId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ClassScheduleModelClass(
      id: id ?? this.id,
      className: className ?? this.className,
      isActive: isActive ?? this.isActive,
      isOngoing: isOngoing ?? this.isOngoing,
      teacherId: teacherId ?? this.teacherId,
      subjectId: subjectId ?? this.subjectId,
      gradeId: gradeId ?? this.gradeId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // fromJson method
  factory ClassScheduleModelClass.fromJson(Map<String, dynamic> json) {
    return ClassScheduleModelClass(
      id: _parseInt(json['classId']),
      className: json['className'],
      isActive: _parseInt(json['isActive']),
      isOngoing: _parseInt(json['isOngoing']),
      createdAt: _parseDateTime(json['createdAt']),
      updatedAt: _parseDateTime(json['updatedAt']),
      teacherId: _parseInt(json['teacherId']),
      teacherFullName: json['teacherFullName'],
      teacherInitialName: json['teacherInitialName'],
      subjectId: _parseInt(json['subjectId']),
      subjectName: json['subjectName'],
      gradeId: _parseInt(json['gradeId']),
      gradeName: json['gradeName'],
    );
  }

  // Helper method for parsing integers safely
  static int? _parseInt(dynamic value) {
    if (value is int) {
      return value; // Already an integer
    } else if (value is String) {
      return int.tryParse(value); // Attempt to parse if it's a string
    }
    return null; // Return null if it's neither an int nor a string
  }

  // Helper method for parsing DateTime safely
  static DateTime? _parseDateTime(dynamic value) {
    if (value is String) {
      return DateTime.tryParse(value); // Attempt to parse if it's a string
    }
    return null; // Return null if it's not a string
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'class_name': className,
      'is_active': isActive,
      'is_ongoing': isOngoing,
      'teacher_id': teacherId,
      'subject_id': subjectId,
      'grade_id': gradeId,
    };
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      'id': id,
      'class_name': className,
      'is_active': isActive,
      'is_ongoing': isOngoing,
      'teacher_id': teacherId,
      'subject_id': subjectId,
      'grade_id': gradeId,
    };
  }

  Map<String, dynamic> toPercentageJson() {
    return {
      'classId': id,
    };
  }
}
