import 'package:equatable/equatable.dart';

class StudentHalfPaymentModel extends Equatable {
  final int? paymentId; // Nullable to handle missing IDs
  final String? paymentFor; // Nullable for missing descriptions
  final double? amount;
  final int? paymentStatus;
  final double? fees;
  final int? attendanceCount;
  final String? categoryName; // Category name
  final String? className; // Class name
  final String? teacherLastName; // Teacher's last name

  const StudentHalfPaymentModel({
    this.paymentId,
    this.paymentFor,
    this.amount,
    this.paymentStatus,
    this.fees,
    this.attendanceCount,
    this.categoryName,
    this.className,
    this.teacherLastName,
  });

  // Factory method to create an instance from JSON
  factory StudentHalfPaymentModel.fromJson(Map<String, dynamic> json) {
    return StudentHalfPaymentModel(
      paymentId: json['paymentId'] != null
          ? int.tryParse(json['paymentId'].toString())
          : null,
      paymentFor: json['payment_for'] ?? '',
      amount: json['amount'] != null
          ? double.tryParse(json['amount'].toString())
          : 0.0,
      paymentStatus: int.parse(json['status'] ?? '0'),
      fees:
          json['fees'] != null ? double.tryParse(json['fees'].toString()) : 0.0,
      attendanceCount: json['attendance_count'] != null
          ? int.tryParse(json['attendance_count'].toString())
          : 0,
      categoryName: json['category_name'], // Add category name
      className: json['class_name'], // Add class name
      teacherLastName: json['lname'], // Add teacher's last name
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'paymentId': paymentId ?? 0, // Default to 0 if null
      'payment_for': paymentFor ?? '', // Default to empty string
      'amount': amount ?? 0.0, // Default to 0.0 if null
      'fees': fees ?? 0.0, // Default to 0.0 if null
      'attendance_count': attendanceCount ?? 0, // Default to 0 if null
      'category_name': categoryName ?? '', // Default to empty string
      'class_name': className ?? '', // Default to empty string
      'lname': teacherLastName ?? '', // Default to empty string
    };
  }

  Map<String, dynamic> halfPaymentUpdate() {
    return {
      'payment_id': paymentId,
      'amount': amount,
    };
  }

  Map<String, dynamic> paymentDeleteJson() {
    return {
      'payment_id': paymentId,
    };
  }

  // CopyWith method for immutability
  StudentHalfPaymentModel copyWith({
    int? paymentId,
    String? paymentFor,
    double? amount,
    double? fees,
    int? attendanceCount,
    String? categoryName,
    String? className,
    String? teacherLastName,
  }) {
    return StudentHalfPaymentModel(
      paymentId: paymentId ?? this.paymentId,
      paymentFor: paymentFor ?? this.paymentFor,
      amount: amount ?? this.amount,
      fees: fees ?? this.fees,
      attendanceCount: attendanceCount ?? this.attendanceCount,
      categoryName: categoryName ?? this.categoryName,
      className: className ?? this.className,
      teacherLastName: teacherLastName ?? this.teacherLastName,
    );
  }

  @override
  List<Object?> get props => [
        paymentId,
        paymentFor,
        amount,
        paymentStatus,
        fees,
        attendanceCount,
        categoryName,
        className,
        teacherLastName,
      ];
}
