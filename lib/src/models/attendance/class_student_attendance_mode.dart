import 'package:equatable/equatable.dart';

class ClassStudentAttendanceMode extends Equatable {
  final int? studentId;
  final String? customId;
  final String? initialName;
  final String? whatsappMobile;
  final int? classRecordId;
  final int? classCategoryHasStudentClassId;
  final DateTime? atDate;
  final String? attendanceStatus;

  const ClassStudentAttendanceMode({
    this.studentId,
    this.customId,
    this.initialName,
    this.whatsappMobile,
    this.classRecordId,
    this.classCategoryHasStudentClassId,
    this.atDate,
    this.attendanceStatus,
  });

  @override
  List<Object?> get props => [
        studentId,
        customId,
        initialName,
        whatsappMobile,
        classRecordId,
        classCategoryHasStudentClassId,
        atDate,
        attendanceStatus,
      ];

  /// Factory method to create an instance from a JSON object
  factory ClassStudentAttendanceMode.fromJson(Map<String, dynamic> json) {
    return ClassStudentAttendanceMode(
      studentId: json['student_id'] is int
          ? json['student_id'] as int?
          : int.tryParse(json['student_id']?.toString() ?? ''), // Safe parsing
      customId: json['custom_id'] as String?,
      initialName: json['lname'] as String?,
      whatsappMobile: json['whatsapp_mobile'] as String?,
      classRecordId: json['class_record_id'] is int
          ? json['class_record_id'] as int?
          : int.tryParse(
              json['class_record_id']?.toString() ?? ''), // Safe parsing
      classCategoryHasStudentClassId:
          json['class_category_has_student_class_id'] is int
              ? json['class_category_has_student_class_id'] as int?
              : int.tryParse(
                  json['class_category_has_student_class_id']?.toString() ??
                      ''),
      atDate: json['at_date'] != null
          ? DateTime.tryParse(json['at_date'].toString())
          : null, // Safe date parsing
      attendanceStatus: json['attendance_status'] as String?,
    );
  }

  /// Method to convert the instance into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'classCategoryHasStudentClassId': classCategoryHasStudentClassId,
      'classDate': atDate?.toIso8601String(),
    };
  }

  /// CopyWith method for creating a modified copy of the instance
  ClassStudentAttendanceMode copyWith({
    int? studentId,
    String? customId,
    String? initialName,
    String? whatsappMobile,
    int? classRecordId,
    int? classCategoryHasStudentClassId,
    DateTime? atDate,
    String? attendanceStatus,
  }) {
    return ClassStudentAttendanceMode(
      studentId: studentId ?? this.studentId,
      customId: customId ?? this.customId,
      initialName: initialName ?? this.initialName,
      whatsappMobile: whatsappMobile ?? this.whatsappMobile,
      classRecordId: classRecordId ?? this.classRecordId,
      classCategoryHasStudentClassId:
          classCategoryHasStudentClassId ?? this.classCategoryHasStudentClassId,
      atDate: atDate ?? this.atDate,
      attendanceStatus: attendanceStatus ?? this.attendanceStatus,
    );
  }
}
