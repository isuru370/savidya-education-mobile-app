import 'package:equatable/equatable.dart';

class ClassAttendanceListModel extends Equatable {
  final int id;
  final String? startMonth;
  final String? endMonth;
  final String? startTime;
  final String? endTime;
  final String? dayOfWeek;
  final int? classHallId;
  final String? classDay;

  const ClassAttendanceListModel({
    required this.id,
    this.startMonth,
    this.endMonth,
    this.startTime,
    this.endTime,
    this.dayOfWeek,
    this.classHallId,
    this.classDay,
  });

  // Factory constructor to create an instance from a JSON map
  factory ClassAttendanceListModel.fromJson(Map<String, dynamic> json) {
    return ClassAttendanceListModel(
      id: int.parse(
          json['class_attendance_id'].toString()), // Safely convert to int
      startMonth: json['start_month'],
      endMonth: json['end_month'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      dayOfWeek: json['day_of_week'],
      classHallId: json['class_hall_id'] != null
          ? int.parse(json['class_hall_id'].toString())
          : null,
      classDay: json['class_date'], // Consistency in naming
    );
  }

  // Convert an instance to a JSON map, including all properties
  Map<String, dynamic> toJson() {
    return {
      'class_attendance_id': id,
      'start_month': startMonth,
      'end_month': endMonth,
      'start_time': startTime,
      'end_time': endTime,
      'day_of_week': dayOfWeek,
      'class_hall_id': classHallId,
      'class_date': classDay,
    };
  }

  @override
  List<Object?> get props => [
        id,
        startMonth,
        endMonth,
        startTime,
        endTime,
        dayOfWeek,
        classHallId,
        classDay,
      ];
}
