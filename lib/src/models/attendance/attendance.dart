import 'package:equatable/equatable.dart';

class StudentAttendanceModelClass extends Equatable {
  final int? attendanceId;
  final DateTime? atDate;
  final String? attendanceStatus;
  final int? classId;
  final int? studentId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // Constructor
  const StudentAttendanceModelClass({
    this.attendanceId,
    this.atDate,
    this.attendanceStatus,
    this.classId,
    this.studentId,
    this.createdAt,
    this.updatedAt,
  });

  // fromJson method
  factory StudentAttendanceModelClass.fromJson(Map<String, dynamic> json) {
    return StudentAttendanceModelClass(
      attendanceId:
          json['attendanceId'] != null ? int.parse(json['attendanceId']) : null,
      atDate: json['atDate'] != null ? DateTime.parse(json['atDate']) : null,
      attendanceStatus: json['attendanceStatus']
          as String?, // Ensure it's treated as a String
      classId: json['student_class_id'] != null
          ? int.parse(json['student_class_id'])
          : null,
      studentId:
          json['studentId'] != null ? int.parse(json['studentId']) : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'attendanceId': attendanceId,
      'class_category_has_student_class_id': classId,
      'student_id': studentId,
    };
  }

  Map<String, dynamic> attendanceMarkJson() {
    return {
      'attendanceId': attendanceId,
      'class_category_has_student_class_id': classId,
      'student_id': studentId,
    };
  }

  Map<String, dynamic> updateJson() {
    return {
      'attendance': attendanceStatus,
      'attendance_status': attendanceStatus,
    };
  }

  // copyWith method
  StudentAttendanceModelClass copyWith({
    int? attendanceId,
    DateTime? atDate,
    String? attendanceStatus,
    int? studentId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StudentAttendanceModelClass(
      attendanceId: attendanceId ?? this.attendanceId,
      atDate: atDate ?? this.atDate,
      attendanceStatus: attendanceStatus ?? this.attendanceStatus,
      studentId: studentId ?? this.studentId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        attendanceId,
        atDate,
        attendanceStatus,
        studentId,
        createdAt,
        updatedAt,
      ];
}

class GetStudentAttendanceModelClass extends Equatable {
  final int? classAttendanceId;
  final int? classStatus;
  final int? classCategoryHasStudentClassId;
  final DateTime? classDate;
  final String? dayName;
  final String? categoryName;
  final String? attendanceStatus;

  const GetStudentAttendanceModelClass({
    this.classAttendanceId,
    this.classStatus,
    this.classCategoryHasStudentClassId,
    this.classDate,
    this.dayName,
    this.categoryName,
    this.attendanceStatus,
  });

// Factory constructor to create an instance from JSON
  factory GetStudentAttendanceModelClass.fromJson(Map<String, dynamic> json) {
    return GetStudentAttendanceModelClass(
      classAttendanceId: json['attendance'] is String
          ? int.parse(json['attendance'])
          : json['attendance'] as int?, // Check if it's already an int
      classStatus: json['status'] is String
          ? int.parse(json['status'])
          : json['status'] as int?, // Check if it's already an int
      classCategoryHasStudentClassId:
          json['class_category_has_student_class_id'] is String
              ? int.parse(json['class_category_has_student_class_id'])
              : json['class_category_has_student_class_id']
                  as int?, // Check if it's already an int
      classDate:
          json['classDate'] != null ? DateTime.parse(json['classDate']) : null,
      dayName: json['day_of_week'] as String?,
      categoryName: json['category_name'] as String?,
      attendanceStatus: json['attendance_status'] as String?,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'attendance': classAttendanceId,
      'status': classStatus,
      'class_category_has_student_class_id': classCategoryHasStudentClassId,
      'classDate': classDate?.toIso8601String(),
      'day_of_week': dayName,
      'category_name': categoryName,
      'attendance_status': attendanceStatus,
    };
  }

  

  @override
  List<Object?> get props => [
        classAttendanceId,
        classStatus,
        classCategoryHasStudentClassId,
        classDate,
        dayName,
        categoryName,
        attendanceStatus,
      ];
}
