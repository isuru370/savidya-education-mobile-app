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
    print(
        "Parsing presentCount: ${json['present_count']} (${json['present_count']?.runtimeType})");
    print(
        "Parsing absentCount: ${json['absent_count']} (${json['absent_count']?.runtimeType})");
    print(
        "Parsing percentage: ${json['percentage']} (${json['percentage']?.runtimeType})");
    print(
        "Parsing attendancePercentage: ${json['attendance_percentage']} (${json['attendance_percentage']?.runtimeType})");

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
      final result = int.tryParse(value);
      if (result == null) {
        print("Failed to parse int from value: $value");
      }
      return result;
    }
    print("Unexpected type for int parsing: $value (${value.runtimeType})");
    return null;
  }

  static double? _parseDouble(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is String) {
      final result = double.tryParse(value);
      if (result == null) {
        print("Failed to parse double from value: $value");
      }
      return result;
    }
    print("Unexpected type for double parsing: $value (${value.runtimeType})");
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
