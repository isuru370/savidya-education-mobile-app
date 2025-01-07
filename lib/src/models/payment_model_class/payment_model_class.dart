import 'package:equatable/equatable.dart';

class PaymentModelClass extends Equatable {
  final int? id;
  final DateTime? paymentDate;
  final int? status;
  final double? amount;
  final String? paymentFor;
  final int? studentId;
  final int? studentClassFreeCard;
  final int? studentStudentStudentClassesId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? studentClassesId;
  final int? classCategoryHasStudentClassId;
  final double? fees;
  final int? classCategoryId;
  final String? categoryName;
  final String? className;
  final String? dayOfWeek;
  final String? startTime;

  const PaymentModelClass({
    this.id,
    this.paymentDate,
    this.status,
    this.amount,
    this.paymentFor,
    this.studentId,
    this.studentClassFreeCard,
    this.studentStudentStudentClassesId,
    this.createdAt,
    this.updatedAt,
    this.studentClassesId,
    this.classCategoryHasStudentClassId,
    this.fees,
    this.classCategoryId,
    this.categoryName,
    this.className,
    this.dayOfWeek,
    this.startTime,
  });

  @override
  List<Object?> get props => [
        id,
        paymentDate,
        status,
        amount,
        paymentFor,
        studentId,
        studentClassFreeCard,
        studentStudentStudentClassesId,
        createdAt,
        updatedAt,
        studentClassesId,
        classCategoryHasStudentClassId,
        fees,
        classCategoryId,
        categoryName,
        className,
        dayOfWeek,
        startTime,
      ];

  factory PaymentModelClass.fromJson(Map<String, dynamic> json) {
    return PaymentModelClass(
      id: _parseInt(json["id"]),
      paymentDate: _parseDateTime(json["payment_date"]),
      status: _parseInt(json["status"]),
      amount: _parseDouble(json["amount"]),
      paymentFor: json["payment_for"],
      studentId: _parseInt(json["student_id"]),
      studentClassFreeCard: _parseInt(json['classFreeCard']),
      studentStudentStudentClassesId:
          _parseInt(json["student_student_student_classes_id"]),
      createdAt: _parseDateTime(json['created_at']),
      updatedAt: _parseDateTime(json['updated_at']),
      studentClassesId: _parseInt(json["student_classes_id"]),
      classCategoryHasStudentClassId:
          _parseInt(json["class_category_has_student_class_id"]),
      fees: _parseDouble(json["fees"]),
      classCategoryId: _parseInt(json["class_category_id"]),
      className: json["class_name"],
      dayOfWeek: json["day_of_week"],
      startTime: json["start_time"],
    );
  }

  factory PaymentModelClass.uniquePaymentJson(Map<String, dynamic> json) {
    return PaymentModelClass(
      paymentDate: _parseDateTime(json["payment_date"]),
      amount: _parseDouble(json["amount"]),
      paymentFor: json["payment_for"],
      categoryName: json["category_name"],
      className: json["class_name"],
    );
  }

  factory PaymentModelClass.studentPaymentFromJson(Map<String, dynamic> json) {
    return PaymentModelClass(
      paymentDate: _parseDateTime(json["payment_date"]),
      paymentFor: json["payment_for"],
      studentStudentStudentClassesId: _parseInt(json["studentStudentClassId"]),
    );
  }

  // Helper method for parsing integers safely
  static int? _parseInt(dynamic value) {
    if (value is int) {
      return value; // Already an integer
    } else if (value is String) {
      return int.tryParse(value); // Attempt to parse if it's a string
    }
    return null; // Return null if it's neither an int nor a string
  }

  // Helper method for parsing doubles safely
  static double? _parseDouble(dynamic value) {
    if (value is double) {
      return value; // Already a double
    } else if (value is String) {
      return double.tryParse(value); // Attempt to parse if it's a string
    }
    return null; // Return null if it's neither a double nor a string
  }

  // Helper method for parsing DateTime safely
  static DateTime? _parseDateTime(dynamic value) {
    if (value is String) {
      return DateTime.tryParse(value); // Attempt to parse if it's a string
    }
    return null; // Return null if it's not a string
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'amount': amount,
      'payment_for': paymentFor,
      'student_id': studentId,
      'student_student_student_classes_id': studentStudentStudentClassesId,
    };
  }
}
