import 'package:equatable/equatable.dart';

class ReportsModel extends Equatable {
  final int paymentId;
  final double paymentAmount;
  final DateTime paymentDate;
  final String? studentCusId;
  final String? studentInitialName;
  final String? gradeName;
  final String? className;
  final String? teacherInitialName;
  final String? subjectName;
  final String? categoryName;

  const ReportsModel({
    required this.paymentId,
    required this.paymentAmount,
    required this.paymentDate,
    this.studentCusId,
    this.studentInitialName,
    this.gradeName,
    this.className,
    this.teacherInitialName,
    this.subjectName,
    this.categoryName,
  });

  factory ReportsModel.fromJson(Map<String, dynamic> json) {
    return ReportsModel(
      paymentId: json['payment_id'] is int
          ? json['payment_id'] as int
          : int.tryParse(json['payment_id']?.toString() ?? '0') ?? 0,
      paymentAmount: json['payment_amount'] is num
          ? (json['payment_amount'] as num).toDouble()
          : double.tryParse(json['payment_amount']?.toString() ?? '0') ?? 0.0,
      paymentDate: DateTime.parse(json['payment_date']),
      studentCusId: json['custom_id'] as String?, // Added here
      studentInitialName: json['student_initial_name'] as String?,
      gradeName: json['grade_name'] as String?,
      className: json['class_name'] as String?,
      teacherInitialName: json['teacher_initial_name'] as String?,
      subjectName: json['subject_name'] as String?,
      categoryName: json['category_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payment_id': paymentId,
      'payment_amount': paymentAmount,
      'payment_date': paymentDate.toIso8601String(),
      'student_cus_id': studentCusId, // Added here
      'student_initial_name': studentInitialName,
      'grade_name': gradeName,
      'class_name': className,
      'teacher_initial_name': teacherInitialName,
      'subject_name': subjectName,
      'category_name': categoryName,
    };
  }

  ReportsModel copyWith({
    int? paymentId,
    double? paymentAmount,
    DateTime? paymentDate,
    String? studentCusId, // Added here
    String? studentInitialName,
    String? gradeName,
    String? className,
    String? teacherInitialName,
    String? subjectName,
    String? categoryName,
  }) {
    return ReportsModel(
      paymentId: paymentId ?? this.paymentId,
      paymentAmount: paymentAmount ?? this.paymentAmount,
      paymentDate: paymentDate ?? this.paymentDate,
      studentCusId: studentCusId ?? this.studentCusId, // Added here
      studentInitialName: studentInitialName ?? this.studentInitialName,
      gradeName: gradeName ?? this.gradeName,
      className: className ?? this.className,
      teacherInitialName: teacherInitialName ?? this.teacherInitialName,
      subjectName: subjectName ?? this.subjectName,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  @override
  List<Object?> get props => [
        paymentId,
        paymentAmount,
        paymentDate,
        studentCusId, // Added here
        studentInitialName,
        gradeName,
        className,
        teacherInitialName,
        subjectName,
        categoryName,
      ];
}
