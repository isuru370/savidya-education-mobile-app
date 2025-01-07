import 'package:equatable/equatable.dart';

class BankBranchModelClass extends Equatable {
  final int? id;
  final int? bankId;
  final String? branchName;
  final int? branchCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // Constructor
  const BankBranchModelClass({
    this.id,
    this.bankId,
    this.branchName,
    this.branchCode,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props =>
      [id, bankId, branchName, branchCode, createdAt, updatedAt];

  factory BankBranchModelClass.fromJson(Map<String, dynamic> json) {
    return BankBranchModelClass(
      id: json["id"] is String
          ? int.parse(json["id"])
          : json["id"] as int?, // Handle if it's already an int
      bankId: json["bank_id"] is String
          ? int.parse(json["bank_id"])
          : json["bank_id"] as int?, // Handle if it's already an int
      branchName: json["branch_name"] as String?,
      branchCode: json["branch_code"] is String
          ? int.parse(json["branch_code"])
          : json["branch_code"] as int?, // Handle if it's already an int
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  // Optional: toString method for easier debugging
  @override
  String toString() {
    return 'BankBranchModelClass(id: $id, bankId: $bankId, branchName: $branchName, branchCode: $branchCode, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
