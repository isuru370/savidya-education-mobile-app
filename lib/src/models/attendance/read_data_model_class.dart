import 'package:equatable/equatable.dart';

class ReadDataModelClass extends Equatable {
  final String? categoryName; // Assuming it's a string, rename accordingly
  final DateTime? classDate; // Assuming it's a date, rename accordingly
  final int? studentStudentClassesId;

  const ReadDataModelClass({
    this.categoryName,
    this.classDate,
    this.studentStudentClassesId,
  });

  @override
  List<Object?> get props => [
        categoryName,
        classDate,
        studentStudentClassesId,
      ];

  // Factory constructor to create an instance from JSON
  factory ReadDataModelClass.fromJson(Map<String, dynamic> json) {
    return ReadDataModelClass(
      categoryName: json['category_name'] as String?, // Ensure it's a string
      classDate: json['class_name'] != null
          ? DateTime.parse(json['class_name']) // Parse DateTime if not null
          : null,
      studentStudentClassesId: json['student_student_classes_id'] != null
          ? int.parse(json['student_student_classes_id']) // Parse integer
          : null,
    );
  }
}
