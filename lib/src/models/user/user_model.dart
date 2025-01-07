import 'package:equatable/equatable.dart';

class MyUserModelClass extends Equatable {
  final int? id;                       // User ID
  final String? userName;              // Username
  final String? email;                 // Email address
  final String? password;              // Password
  final String? emailVerifiedAt;       // Email verification timestamp
  final int? userTypeId;               // User type ID
  final String? userType;              // User type
  final int? isActive;                 // Active status
  final String? rememberToken;         // Remember token for sessions
  final DateTime? createdAt;           // Creation timestamp
  final DateTime? updatedAt;           // Update timestamp

  // System user specific fields
  final int? systemUserId;             // System User ID
  final String? systemUserCusId;       // System User Custom ID
  final String? firstName;              // First Name
  final String? lastName;               // Last Name
  final String? mobileNumber;           // Mobile Number
  final String? nic;                    // NIC (National Identity Card)
  final String? birthday;               // Birthday
  final String? gender;                 // Gender
  final String? addressLine1;           // Address Line 1
  final String? addressLine2;           // Address Line 2
  final String? addressLine3;           // Address Line 3
  final DateTime? systemUserUpdate;    // System user update timestamp

  const MyUserModelClass({
    this.id,
    this.userName,
    this.email,
    this.password,
    this.emailVerifiedAt,
    this.userTypeId,
    this.userType,
    this.isActive,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
    this.systemUserId,
    this.systemUserCusId,
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.nic,
    this.birthday,
    this.gender,
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.systemUserUpdate,
  });

  // JSON to MyUserModelClass object
  factory MyUserModelClass.fromJson(Map<String, dynamic> json) {
    return MyUserModelClass(
      id: json['systemUserId'] is int ? json['systemUserId'] : int.tryParse(json['systemUserId'].toString()),
      systemUserCusId: json['custom_id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      mobileNumber: json['mobileNo'] as String?,
      nic: json['nic'] as String?,
      birthday: json['birthday'] as String?,
      gender: json['gender'] as String?,
      addressLine1: json['addressLine1'] as String?,
      addressLine2: json['addressLine2'] as String?,
      addressLine3: json['addressLine3'] as String?,
      isActive: json['isActive'] is int ? json['isActive'] : int.tryParse(json['isActive'].toString()),
      userTypeId: json['userTypeId'] is int ? json['userTypeId'] : int.tryParse(json['userTypeId'].toString()),
      userType: json['userType'] as String?,
      systemUserUpdate: json['systemUserUpdate'] != null ? DateTime.tryParse(json['systemUserUpdate']) : null,
      createdAt: json['createAt'] != null ? DateTime.tryParse(json['createAt']) : null,
      updatedAt: json['updateAt'] != null ? DateTime.tryParse(json['updateAt']) : null,
    );
  }

  // MyUserModelClass object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'password': password,
      'userTypeId': userTypeId,
      'isActive': isActive,
      'firstName': firstName,
      'lastName': lastName,
      'mobileNo': mobileNumber,
      'nic': nic,
      'birthday': birthday,
      'gender': gender,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'addressLine3': addressLine3,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  // Login JSON
  Map<String, dynamic> userLoginToJson() {
    return {
      'userName': userName,
      'password': password,
    };
  }

  // CopyWith method
  MyUserModelClass copyWith({
    int? id,
    String? userName,
    String? email,
    String? password,
    String? emailVerifiedAt,
    int? userTypeId,
    String? userType,
    int? isActive,
    String? rememberToken,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? systemUserId,
    String? systemUserCusId,
    String? firstName,
    String? lastName,
    String? mobileNumber,
    String? nic,
    String? birthday,
    String? gender,
    String? addressLine1,
    String? addressLine2,
    String? addressLine3,
    DateTime? systemUserUpdate,
  }) {
    return MyUserModelClass(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      userTypeId: userTypeId ?? this.userTypeId,
      userType: userType ?? this.userType,
      isActive: isActive ?? this.isActive,
      rememberToken: rememberToken ?? this.rememberToken,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      systemUserId: systemUserId ?? this.systemUserId,
      systemUserCusId: systemUserCusId ?? this.systemUserCusId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      nic: nic ?? this.nic,
      birthday: birthday ?? this.birthday,
      gender: gender ?? this.gender,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      addressLine3: addressLine3 ?? this.addressLine3,
      systemUserUpdate: systemUserUpdate ?? this.systemUserUpdate,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userName,
        email,
        password,
        emailVerifiedAt,
        userTypeId,
        userType,
        isActive,
        rememberToken,
        createdAt,
        updatedAt,
        systemUserId,
        systemUserCusId,
        firstName,
        lastName,
        mobileNumber,
        nic,
        birthday,
        gender,
        addressLine1,
        addressLine2,
        addressLine3,
        systemUserUpdate,
      ];
}
