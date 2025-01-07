import 'package:equatable/equatable.dart';

class Subject extends Equatable {
  final int id;
  final String subjectName;
  final String? createdAt;
  final String? updatedAt;

  const Subject({
    required this.id,
    required this.subjectName,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id, subjectName, createdAt, updatedAt];

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: _parseInt(json['id']),
      subjectName: json['subject_name'] as String,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject_name':
          subjectName, // Fixed key from 'grade_name' to 'subject_name'
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  static int _parseInt(dynamic value) {
    if (value is int) {
      return value; // Already an integer
    } else if (value is String) {
      return int.tryParse(value) ??
          (throw const FormatException(
              'Invalid integer format')); // Attempt to parse as int
    }
    throw const FormatException(
        'Expected an integer or string representation of an integer');
  }
}
