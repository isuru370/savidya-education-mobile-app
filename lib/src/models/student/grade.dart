import 'package:equatable/equatable.dart';

class Grade extends Equatable {
  final int id;
  final String gradeName;
  final String? createdAt;
  final String? updatedAt;

  const Grade({
    required this.id,
    required this.gradeName,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id, gradeName, createdAt, updatedAt];

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      id: _parseInt(json['id']),
      gradeName: json['grade_name'] ?? "", // Use a default value if null
      createdAt: json['created_at'], // Keep as String or use parsing if needed
      updatedAt: json['updated_at'], // Keep as String or use parsing if needed
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'grade_name': gradeName,
      'created_at':
          createdAt, // Include createdAt and updatedAt in toJson if needed
      'updated_at': updatedAt,
    };
  }

  // Safe parsing method for integers
  static int _parseInt(dynamic value) {
    if (value is int) {
      return value; // Already an integer
    } else if (value is String) {
      return int.tryParse(value) ??
          0; // Attempt to parse as int, default to 0 if parsing fails
    }
    return 0; // Return 0 if value is neither an int nor a string
  }
}
