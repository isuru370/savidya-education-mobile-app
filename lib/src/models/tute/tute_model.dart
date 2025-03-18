import 'package:equatable/equatable.dart';

class TuteModelClass extends Equatable {
  final int? tuteId;
  final int? studentId;
  final String? studentName;
  final String? studentCusId;
  final String? className;
  final int? classCategoryHasClassId;
  final String? classCategoryName;
  final String? tuteFor;
  final DateTime? createAt;
  final DateTime? updateAt;

  const TuteModelClass({
    this.tuteId,
    this.studentId,
    this.studentName,
    this.studentCusId,
    this.className,
    this.classCategoryHasClassId,
    this.classCategoryName,
    this.tuteFor,
    this.createAt,
    this.updateAt,
  });

  factory TuteModelClass.fromJson(Map<String, dynamic> json) {
    return TuteModelClass(
      tuteId: json['tute_id'] is int
          ? json['tute_id']
          : int.tryParse(json['tute_id']?.toString() ?? '0'),
      studentId: json['student_id'] is int
          ? json['student_id']
          : int.tryParse(json['student_id']?.toString() ?? '0'),
      studentName: json['initial_name'] ?? "",
      studentCusId: json['custom_id'] ?? "",
      className: json['class_name'] ?? "",
      classCategoryHasClassId: json['class_category_has_class_id'] is int
          ? json['class_category_has_class_id']
          : int.tryParse(
              json['class_category_has_class_id']?.toString() ?? '0'),
      classCategoryName: json['category_name'] ?? "0",
      tuteFor: json['titute_for'] ?? "",
      createAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updateAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'class_category_has_student_class_id': classCategoryHasClassId,
      'titute_for': tuteFor,
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      'id': tuteId,
      'student_id': studentId,
      'class_category_has_student_class_id': classCategoryHasClassId,
      'titute_for': tuteFor,
    };
  }

  @override
  List<Object?> get props => [
        tuteId,
        studentId,
        studentCusId,
        studentCusId,
        className,
        classCategoryHasClassId,
        classCategoryName,
        tuteFor,
        createAt,
        updateAt,
      ];
}
