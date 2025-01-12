import 'package:equatable/equatable.dart';

class PercentageModelClass extends Equatable {
  final int? presentCount;
  final int? absentCount;
  final double? percentage;
  final double? attendancePercentage;

  const PercentageModelClass({
    this.presentCount,
    this.absentCount,
    this.percentage,
    this.attendancePercentage,
  });

  factory PercentageModelClass.fromJson(Map<String, dynamic> json) {
    return PercentageModelClass(
      presentCount: _parseInt(json['present_count']),
      absentCount: _parseInt(json['absent_count']),
      percentage: _parseDouble(json['percentage']),
      attendancePercentage: _parseDouble(json['attendance_percentage']),
    );
  }

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

  @override
  List<Object?> get props => [
        presentCount,
        absentCount,
        percentage,
        attendancePercentage,
      ];
}
