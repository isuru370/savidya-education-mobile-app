import 'package:equatable/equatable.dart';

class ClassAttendanceModelClass extends Equatable {
  final int? classAttId;
  final String? startMonth;
  final String? endMonth;
  final int? classStatus;
  final int? classCategoryHasStudentId;
  final String? classStartTime;
  final String? classEndTime;
  final String? dayDayName;
  final int? onGoing;
  final int? classHallId;
  final String? classHallName;
  final String? classDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? categoryId;
  final String? categoryName;
  final String? className;
  final String? subjectName;
  final String? gradeName;
  final String? initialName;

  const ClassAttendanceModelClass({
    this.classAttId,
    this.startMonth,
    this.endMonth,
    this.classStatus,
    this.classCategoryHasStudentId,
    this.classStartTime,
    this.classEndTime,
    this.dayDayName,
    this.onGoing,
    this.classHallId,
    this.classHallName,
    this.classDate,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
    this.categoryName,
    this.className,
    this.subjectName,
    this.gradeName,
    this.initialName,
  });

  @override
  List<Object?> get props => [
        classAttId,
        startMonth,
        endMonth,
        classStatus,
        classCategoryHasStudentId,
        classStartTime,
        classEndTime,
        dayDayName,
        onGoing,
        classHallId,
        classHallName,
        classDate,
        createdAt,
        updatedAt,
        categoryId,
        className,
        subjectName,
        gradeName,
        initialName,
      ];

  @override
  String toString() {
    return 'ClassAttendanceModelClass(classAttId: $classAttId, startMonth: $startMonth, endMonth: $endMonth, classCategoryHasStudentId: $classCategoryHasStudentId, classStartTime: $classStartTime, classEndTime: $classEndTime, dayDayName: $dayDayName, onGoing: $onGoing, classHallId: $classHallId, classDate: $classDate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  // Factory method for creating an instance from JSON
  factory ClassAttendanceModelClass.fromJson(Map<String, dynamic> json) {
    return ClassAttendanceModelClass(
      classAttId: json['classAttId'] is String
          ? int.parse(json['classAttId'])
          : json['classAttId'] as int?,
      startMonth: json['classStartMonth'] as String?,
      endMonth: json['classEndMonth'] as String?,
      classStatus: json['classStatus'] is String
          ? int.parse(json['classStatus'])
          : json['classStatus'] as int?,
      classCategoryHasStudentId: json['classCatId'] is String
          ? int.parse(json['classCatId'])
          : json['classCatId'] as int?,
      classStartTime: json['startTime'] as String?,
      classEndTime: json['endTime'] as String?,
      dayDayName: json['classDayName'] as String?,
      onGoing: json['onGoing'] is String
          ? int.parse(json['onGoing'])
          : json['onGoing'] as int?,
      classHallId: json['classHallId'] is String
          ? int.parse(json['classHallId'])
          : json['classHallId'] as int?,
      classHallName: json['hallName'] as String?,
      classDate: json['classDate'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      categoryId: json['categoryId'] is String
          ? int.parse(json['categoryId'])
          : json['categoryId'] as int?,
      categoryName: json['categoryName'] as String?,
      className: json['className'] as String?,
      subjectName: json['subjectName'] as String?,
      gradeName: json['gradeName'] as String?,
      initialName: json['initialName'] as String?,
    );
  }

  // Method for converting an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'startMonth': startMonth,
      'endMonth': endMonth,
      'classStatus': classStatus,
      'classCategoryHasStudentId': classCategoryHasStudentId,
      'classStartTime': classStartTime,
      'classEndTime': classEndTime,
      'dayDayName': dayDayName,
      'onGoing': onGoing,
      'classHallId': classHallId,
      'classDate': classDate,
    };
  }

  Map<String, dynamic> reScheduleJson() {
    return {
      'classAttId': classAttId,
      'classStatus': classStatus,
      'classStartTime': classStartTime,
      'classEndTime': classEndTime,
      'dayDayName': dayDayName,
      'classHallId': classHallId,
      'classDate': classDate,
    };
  }
}
