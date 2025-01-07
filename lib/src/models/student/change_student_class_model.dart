import 'package:equatable/equatable.dart';

class ChangeStudentClassModel extends Equatable {
  final int? studentStudentClassId;
  final int? classHasCatId;
  final int? catId;
  final String? className;
  final String? categoryName;

  // Constructor
  const ChangeStudentClassModel({
    this.studentStudentClassId,
    this.classHasCatId,
    this.catId,
    this.className,
    this.categoryName,
  });

  // Factory constructor to create an instance from JSON
  factory ChangeStudentClassModel.fromJson(Map<String, dynamic> json) {
    return ChangeStudentClassModel(
      studentStudentClassId: _parseInt(json['studentStudentClassId']),
      classHasCatId: _parseInt(json['classHasCatId']),
      catId: _parseInt(json['catId']),
      className: json['className'] as String?,
      categoryName: json['categoryName'] as String?,
    );
  }

  // Safe parsing method for integers
  static int? _parseInt(dynamic value) {
    if (value is int) {
      return value; // Already an integer
    } else if (value is String) {
      return int.tryParse(value); // Attempt to parse if it's a string
    }
    return null; // Return null if it's neither an int nor a string
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'studentStudentClassId': studentStudentClassId,
      'classHasCatId': classHasCatId,
      'catId': catId,
      'className': className,
      'categoryName': categoryName,
    };
  }

  @override
  List<Object?> get props => [
        studentStudentClassId,
        classHasCatId,
        catId,
        className,
        categoryName,
      ];
}
