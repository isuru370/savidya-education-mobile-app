import 'package:equatable/equatable.dart';

class AdmissionPaymentModelClass extends Equatable {
  final int? id;
  final int? studentId;
  final double? amount;
  final int? admissionId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  //today admission payment
  final String? stuCustomId;
  final String? stuInitialName;
  final String? admissionName;

  // Constructor
  const AdmissionPaymentModelClass({
    this.id,
    this.studentId,
    this.amount,
    this.admissionId,
    this.createdAt,
    this.updatedAt,
    //
    this.stuCustomId,
    this.stuInitialName,
    this.admissionName,
  });

  @override
  List<Object?> get props => [
        id,
        studentId,
        amount,
        admissionId,
        createdAt,
        updatedAt,
        //
        stuCustomId,
        stuInitialName,
        admissionName,
      ];

  // Convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'amount': amount,
      'admissionId': admissionId,
    };
  }

  // Create an instance from JSON
  factory AdmissionPaymentModelClass.fromJson(Map<String, dynamic> json) {
    return AdmissionPaymentModelClass(
      id: json['id'] is int ? json['id'] : int.parse(json['id']),
      studentId: json['student_id'] is int
          ? json['student_id']
          : int.parse(json['student_id']),
      amount: json['amount'] is double
          ? json['amount']
          : double.parse(json['amount']),
      admissionId: json['admission_id'] is int
          ? json['admission_id']
          : int.parse(json['admission_id']),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  // Create an instance from JSON
  factory AdmissionPaymentModelClass.admissionPayFromJson(
      Map<String, dynamic> json) {
    return AdmissionPaymentModelClass(
      id: json['admission_payment_id'] is int
          ? json['admission_payment_id']
          : int.parse(json['admission_payment_id']),
      studentId: json['student_id'] is int
          ? json['student_id']
          : int.parse(json['student_id']),
      amount: json['amount'] is double
          ? json['amount']
          : double.parse(json['amount']),
      admissionId: json['admission_id'] is int
          ? json['admission_id']
          : int.parse(json['admission_id']),
      stuCustomId: json['custom_id'],
      stuInitialName: json['lname'],
      admissionName: json['name'],
    );
  }

  @override
  String toString() {
    return 'AdmissionPaymentModelClass(studentId: $studentId, amount: $amount, admissionId: $admissionId, createdAt: $createdAt, updatedAt: $updatedAt, custom_id: $stuCustomId, lname: $stuInitialName,name : $admissionName)';
  }
}
