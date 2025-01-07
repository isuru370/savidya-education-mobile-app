import 'package:equatable/equatable.dart';

class AdmissionModelClass extends Equatable {
  final int? admissionId;
  final int? studentId;
  final String? admissionName;
  final double? admissionAmount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AdmissionModelClass({
    this.admissionId,
    this.studentId,
    this.admissionName,
    this.admissionAmount,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        admissionId,
        studentId,
        admissionName,
        admissionAmount,
        createdAt,
        updatedAt,
      ];

  // From JSON (deserialization)
  factory AdmissionModelClass.fromJson(Map<String, dynamic> json) {
    return AdmissionModelClass(
      admissionId: json['id'] is int
          ? json['id']
          : (json['id'] != null ? int.tryParse(json['id'].toString()) : null),
      admissionName: json['name']?.toString(),
      admissionAmount: json['amount'] is double
          ? json['amount']
          : (json['amount'] != null
              ? double.tryParse(json['amount'].toString())
              : null),
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'].toString())
          : null,
    );
  }

  // To JSON (serialization)
  Map<String, dynamic> toJson() {
    return {
      'admissionName': admissionName,
      'admissionAmount': admissionAmount,
    };
  }

  Map<String, dynamic> studentAdmissionToJson() {
    return {
      'admission_id': admissionName,
      'admission_amount': admissionAmount,
      'student_id' : studentId,
    };
  }

  Map<String, dynamic> updateToJson() {
    return {
      'studentId': studentId,
    };
  }
}
