import 'package:equatable/equatable.dart';

class ClassHasTeacherModelClass extends Equatable {
  final int? id;
  final String? className;
  final List<String>? selectedDays;
  final String? startTime;
  final String? endTime;
  final int? isActive;
  final int? isOngoing;
  final int? teacherId;
  final int? subjectId;
  final int? gradeId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // Inner join column names
  final String? teacherFullName;
  final String? teacherInitialName;
  final String? subjectName;
  final String? gradeName;

  const ClassHasTeacherModelClass({
    this.id,
    this.className,
    this.selectedDays,
    this.startTime,
    this.endTime,
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
        selectedDays,
        startTime,
        endTime,
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
  ClassHasTeacherModelClass copyWith({
    int? id,
    String? className,
    List<String>? selectedDays,
    String? startTime,
    String? endTime,
    int? isActive,
    int? isOngoing,
    int? teacherId,
    int? subjectId,
    int? gradeId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? teacherFullName,
    String? teacherInitialName,
    String? subjectName,
    String? gradeName,
  }) {
    return ClassHasTeacherModelClass(
      id: id ?? this.id,
      className: className ?? this.className,
      selectedDays: selectedDays ?? this.selectedDays,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isActive: isActive ?? this.isActive,
      isOngoing: isOngoing ?? this.isOngoing,
      teacherId: teacherId ?? this.teacherId,
      subjectId: subjectId ?? this.subjectId,
      gradeId: gradeId ?? this.gradeId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      teacherFullName: teacherFullName ?? this.teacherFullName,
      teacherInitialName: teacherInitialName ?? this.teacherInitialName,
      subjectName: subjectName ?? this.subjectName,
      gradeName: gradeName ?? this.gradeName,
    );
  }

  // fromJson method
  factory ClassHasTeacherModelClass.fromJson(Map<String, dynamic> json) {
    return ClassHasTeacherModelClass(
      id: _parseInt(json['classId']),
      className: json['className'],
      selectedDays: json['selectedDays'] != null
          ? List<String>.from(json['selectedDays'])
          : null,
      startTime: json['startTime'],
      endTime: json['endTime'],
      isActive: _parseInt(json['isActive']),
      isOngoing: _parseInt(json['isOngoing']),
      teacherId: _parseInt(json['teacherId']),
      subjectId: _parseInt(json['subjectId']),
      gradeId: _parseInt(json['gradeId']),
      createdAt: _parseDateTime(json['createdAt']),
      updatedAt: _parseDateTime(json['updatedAt']),
      teacherFullName: json['teacherFullName'],
      teacherInitialName: json['teacherInitialName'],
      subjectName: json['subjectName'],
      gradeName: json['gradeName'],
    );
  }

  // Helper methods for parsing
  static int? _parseInt(dynamic value) {
    if (value is int) {
      return value; // Return if it's already an integer
    } else if (value is String) {
      return int.tryParse(value); // Attempt to parse if it's a string
    }
    return null; // Return null if not an int or string
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value is String) {
      return DateTime.tryParse(value); // Attempt to parse if it's a string
    }
    return null; // Return null if not a string
  }

  // toPercentageJson method
  Map<String, dynamic> toPercentageJson() {
    return {
      'classId': id,
    };
  }
}
