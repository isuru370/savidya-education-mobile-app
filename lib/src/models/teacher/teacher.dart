import 'package:equatable/equatable.dart';

class TeacherModelClass extends Equatable {
  final int? id; // Teacher ID
  final String? teacherCusId; // Custom ID for the teacher
  final String? fullName; // Full name of the teacher
  final String? initialName; // Initials of the teacher
  final String? email; // Email address
  final String? mobile; // Mobile number
  final String? nic; // NIC (National Identity Card)
  final String? birthday; // Birthday
  final String? gender; // Gender
  final String? address1; // Address line 1
  final String? address2; // Address line 2
  final String? address3; // Address line 3
  final int? isActive; // Active status
  final String? graduationDetails; // Graduation details
  final String? experience; // Experience details
  final double? percentage; // Percentage
  final String? accountNo; // Account number
  final int? bankId; // Bank ID
  final int? branchId; // Branch ID
  final DateTime? createdAt; // Creation timestamp
  final DateTime? updatedAt; // Update timestamp

  const TeacherModelClass({
    this.id,
    this.teacherCusId,
    this.fullName,
    this.initialName,
    this.email,
    this.mobile,
    this.nic,
    this.birthday,
    this.gender,
    this.address1,
    this.address2,
    this.address3,
    this.isActive,
    this.graduationDetails,
    this.experience,
    this.percentage,
    this.accountNo,
    this.bankId,
    this.branchId,
    this.createdAt,
    this.updatedAt,
  });

  TeacherModelClass copyWith({
    int? id,
    String? teacherCusId,
    String? fullName,
    String? initialName,
    String? email,
    String? mobile,
    String? nic,
    String? birthday,
    String? gender,
    String? address1,
    String? address2,
    String? address3,
    int? isActive,
    String? graduationDetails,
    String? experience,
    double? percentage,
    String? accountNo,
    int? bankId,
    int? branchId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TeacherModelClass(
      id: id ?? this.id,
      teacherCusId: teacherCusId ?? this.teacherCusId,
      fullName: fullName ?? this.fullName,
      initialName: initialName ?? this.initialName,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      nic: nic ?? this.nic,
      birthday: birthday ?? this.birthday,
      gender: gender ?? this.gender,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      address3: address3 ?? this.address3,
      isActive: isActive ?? this.isActive,
      graduationDetails: graduationDetails ?? this.graduationDetails,
      experience: experience ?? this.experience,
      percentage: percentage ?? this.percentage,
      accountNo: accountNo ?? this.accountNo,
      bankId: bankId ?? this.bankId,
      branchId: branchId ?? this.branchId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory TeacherModelClass.fromJson(Map<String, dynamic> json) {
    return TeacherModelClass(
      id: json['teacherId'] is int
          ? json['teacherId']
          : int.tryParse(json['teacherId'].toString()),
      teacherCusId: json['teacherCustomId'] as String?,
      fullName: json['fullName'] as String?,
      initialName: json['initialName'] as String?,
      email: json['email'] as String?,
      mobile: json['mobileNo'] as String?,
      nic: json['teacherNic'] as String?,
      birthday: json['birthday'] as String?,
      gender: json['gender'] as String?,
      address1: json['addressLine1'] as String?,
      address2: json['addressLine2'] as String?,
      address3: json['addressLine3'] as String?,
      isActive: json['isActive'] is int
          ? json['isActive']
          : int.tryParse(json['isActive'].toString()),
      graduationDetails: json['graduationDetails'] as String?,
      experience: json['experience'] as String?,
      percentage: json['percentage'] is double
          ? json['percentage']
          : double.tryParse(json['percentage'].toString()),
      accountNo: json['accountNo'] as String?,
      bankId: json['bankId'] is int
          ? json['bankId']
          : int.tryParse(json['bankId'].toString()),
      branchId: json['branchId'] is int
          ? json['branchId']
          : int.tryParse(json['branchId'].toString()),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teacherId': id,
      'teacherCustomId': teacherCusId,
      'fullName': fullName,
      'initialName': initialName,
      'email': email,
      'mobileNo': mobile,
      'teacherNic': nic,
      'birthday': birthday,
      'gender': gender,
      'addressLine1': address1,
      'addressLine2': address2,
      'addressLine3': address3,
      'isActive': isActive,
      'graduationDetails': graduationDetails,
      'experience': experience,
      'percentage': percentage,
      'accountNo': accountNo,
      'bankId': bankId,
      'branchId': branchId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      'teacherId': id,
      'fullName': fullName,
      'initialName': initialName,
      'email': email,
      'mobileNo': mobile,
      'teacherNic': nic,
      'birthday': birthday,
      'gender': gender,
      'addressLine1': address1,
      'addressLine2': address2,
      'addressLine3': address3,
      'isActive': isActive,
      'graduationDetails': graduationDetails,
      'experience': experience,
      'percentage': percentage,
      'accountNo': accountNo,
      'bankId': bankId,
      'branchId': branchId,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        teacherCusId,
        fullName,
        initialName,
        email,
        mobile,
        nic,
        birthday,
        gender,
        address1,
        address2,
        address3,
        isActive,
        graduationDetails,
        experience,
        percentage,
        accountNo,
        bankId,
        branchId,
        createdAt,
        updatedAt,
      ];
}
