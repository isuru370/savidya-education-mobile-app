import 'package:equatable/equatable.dart';

class BankModelClass extends Equatable {
  final int? id;
  final String? bankName;
  final int? bankCode;
  final DateTime? createdAt;
  final DateTime? updatedAt; // Fixed typo from 'updateAt' to 'updatedAt'

  // Constructor
  const BankModelClass({
    this.id,
    this.bankName,
    this.bankCode,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id, bankName, bankCode, createdAt, updatedAt];

  factory BankModelClass.fromJson(Map<String, dynamic> json) {
    return BankModelClass(
      id: json["id"] is String
          ? int.parse(json["id"])
          : json["id"] as int?, // Check if it's already an int
      bankName: json["bank_name"] as String?,
      bankCode: json["bank_code"] is String
          ? int.parse(json["bank_code"])
          : json["bank_code"] as int?, // Check if it's already an int
      createdAt:
          json['createAt'] != null ? DateTime.parse(json['createAt']) : null,
      updatedAt:
          json['updateAt'] != null ? DateTime.parse(json['updateAt']) : null,
    );
  }

  // Optional: toString method for easier debugging
  @override
  String toString() {
    return 'BankModelClass(id: $id, bankName: $bankName, bankCode: $bankCode, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
