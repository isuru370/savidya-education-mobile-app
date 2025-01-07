import 'package:equatable/equatable.dart';

class StudentModelClass extends Equatable {
  final int? id;
  final String? cusId;
  final String? fullName;
  final String? initialName;
  final String? schoolName;
  final String? mobileNumber;
  final String? whatsappNumber;
  final String? emailAddress;
  final String? studentNic;
  final String? birthDay;
  final String? gender;
  final int? freeCard;
  final int? admission;
  final String? addressLine1;
  final String? addressLine2;
  final String? addressLine3;
  final int? gradeId;
  final String? guardianFName;
  final String? guardianLName;
  final String? guardianNic;
  final String? guardianMNumber;
  final int? activeStatus;
  final String? studentImageUrl;
  final int? quickImageId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? classHasCatId;

  // inner join  colum name

  final int? classId;
  final String? className;
  final int? teacherId;
  final String? teacherFullName;
  final String? teacherInitialName;
  final int? subjectId;
  final String? subjectName;
  final String? gradeName;
  final int? studentHasClassId;

  const StudentModelClass({
    this.id,
    this.cusId,
    this.fullName,
    this.initialName,
    this.schoolName,
    this.mobileNumber,
    this.whatsappNumber,
    this.emailAddress,
    this.studentNic,
    this.birthDay,
    this.gender,
    this.freeCard,
    this.admission,
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.gradeId,
    this.guardianFName,
    this.guardianLName,
    this.guardianNic,
    this.guardianMNumber,
    this.activeStatus,
    this.studentImageUrl,
    this.quickImageId,
    this.createdAt,
    this.updatedAt,

// inner join colum name
    this.classId,
    this.className,
    this.teacherId,
    this.teacherFullName,
    this.teacherInitialName,
    this.subjectId,
    this.subjectName,
    this.gradeName,
    this.studentHasClassId,
    this.classHasCatId,
  });

  @override
  List<Object?> get props => [
        id,
        cusId,
        fullName,
        initialName,
        schoolName,
        mobileNumber,
        whatsappNumber,
        emailAddress,
        studentNic,
        birthDay,
        gender,
        freeCard,
        admission,
        addressLine1,
        addressLine2,
        addressLine3,
        gradeId,
        guardianFName,
        guardianLName,
        guardianNic,
        guardianMNumber,
        activeStatus,
        gradeName,
        subjectName,
        studentImageUrl,
        quickImageId,
        createdAt,
        updatedAt,
        classHasCatId,
      ];

  StudentModelClass copyWith(
      {int? id,
      String? cusId,
      String? fullName,
      String? initialName,
      String? schoolName,
      String? mobileNumber,
      String? whatsappNumber,
      String? emailAddress,
      String? studentNic,
      String? birthDay,
      String? gender,
      int? freeCard,
      int? admission,
      String? addressLine1,
      String? addressLine2,
      String? addressLine3,
      int? gradeId,
      String? guardianFName,
      String? guardianLName,
      String? guardianNic,
      String? guardianMNumber,
      String? studentImgUrl,
      int? activeStatus,
      String? studentImageUrl,
      int? quickImageId,
      int? classId,
      int? classHasCatId}) {
    return StudentModelClass(
      id: id ?? this.id,
      cusId: cusId ?? this.cusId,
      fullName: fullName ?? this.fullName,
      initialName: initialName ?? this.initialName,
      schoolName: schoolName ?? this.schoolName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      whatsappNumber: whatsappNumber ?? this.whatsappNumber,
      emailAddress: emailAddress ?? this.emailAddress,
      studentNic: studentNic ?? this.studentNic,
      birthDay: birthDay ?? this.birthDay,
      gender: gender ?? this.gender,
      freeCard: freeCard ?? this.freeCard,
      admission: admission ?? this.admission,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      addressLine3: addressLine3 ?? this.addressLine3,
      gradeId: gradeId ?? this.gradeId,
      guardianFName: guardianFName ?? this.guardianFName,
      guardianLName: guardianLName ?? this.guardianLName,
      guardianNic: guardianNic ?? this.guardianNic,
      guardianMNumber: guardianMNumber ?? this.guardianMNumber,
      activeStatus: activeStatus ?? this.activeStatus,
      studentImageUrl: studentImageUrl ?? this.studentImageUrl,
      quickImageId: quickImageId ?? this.quickImageId,
      classId: classId ?? classId,
      classHasCatId: classHasCatId ?? this.classHasCatId,
    );
  }

  factory StudentModelClass.fromJson(Map<String, dynamic> json) {
    return StudentModelClass(
      id: json['id'] is int ? json['id'] : int.parse(json['id']),
      cusId: json['custom_id'] ?? "",
      fullName: json['fname'] ?? "",
      initialName: json['lname'],
      schoolName: json['student_school'] ?? "",
      mobileNumber: json['mobile'] ?? "",
      whatsappNumber: json['whatsapp_mobile'],
      emailAddress: json['email'] ?? "",
      studentNic: json['nic'] ?? "",
      birthDay: json['bday'] ?? "",
      gender: json['gender'] ?? "",
      freeCard: json['is_freecard'] is int
          ? json['is_freecard']
          : int.parse(json['is_freecard']),
      admission: json['admission'] is int
          ? json['admission']
          : int.parse(json['admission']),
      addressLine1: json['address1'],
      addressLine2: json['address2'],
      addressLine3: json['address3'],
      gradeId: json['grade_id'] is int
          ? json['grade_id']
          : int.parse(json['grade_id']),
      gradeName: json['grade_name'],
      guardianFName: json['guardian_fname'],
      guardianLName: json['guardian_lname'],
      guardianNic: json['guardian_nic'],
      guardianMNumber: json['guardian_mobile'],
      studentImageUrl: json['img_url'],
      activeStatus: json['is_active'] is int
          ? json['is_active']
          : int.parse(json['is_active']),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  factory StudentModelClass.attendanceJson(Map<String, dynamic> json) {
    return StudentModelClass(
      id: json['student_id'] is int
          ? json['student_id']
          : int.parse(json['student_id']),
      initialName: json['initialName'],
      mobileNumber: json['mobileNo'],
      freeCard: json['freeCard'] is int
          ? json['freeCard']
          : int.parse(json['freeCard']),
      guardianMNumber: json['guardianMobile'],
      studentImageUrl: json['ImageUrl'],
    );
  }

  Map<String, dynamic> studentModelClassInsertDataJson() {
    return {
      'firstName': fullName,
      'lastName': initialName,
      'schoolName': schoolName,
      'mobileNumber': mobileNumber,
      'whatsappNumber': whatsappNumber,
      'emailAddress': emailAddress,
      'studentNic': studentNic,
      'birthDay': birthDay,
      'gender': gender,
      'freeCard': freeCard,
      'admission': admission,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'addressLine3': addressLine3,
      'gradeId': gradeId,
      'guardianFName': guardianFName,
      'guardianLName': guardianLName,
      'guardianNic': guardianNic,
      'guardianMNumber': guardianMNumber,
      'studentImgUrl': studentImageUrl,
      'activeStatus': activeStatus,
      'quickImageId': quickImageId,
    };
  }

  Map<String, dynamic> toUpdateStudentJson() {
    return {
      'id': id,
      'firstName': fullName,
      'lastName': initialName,
      'schoolName': schoolName,
      'mobileNumber': mobileNumber,
      'whatsappNumber': whatsappNumber,
      'emailAddress': emailAddress,
      'studentNic': studentNic,
      'birthDay': birthDay,
      'gender': gender,
      'freeCard': freeCard,
      'admission': admission,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'addressLine3': addressLine3,
      'gradeId': gradeId,
      'guardianFName': guardianFName,
      'guardianLName': guardianLName,
      'guardianNic': guardianNic,
      'guardianMNumber': guardianMNumber,
      'studentImgUrl': studentImageUrl,
      'activeStatus': activeStatus,
      'quickImageId': quickImageId,
    };
  }

  Map<String, dynamic> studentHasClassToJson() {
    return {
      'studentId': id,
    };
  }

  Map<String, dynamic> studentAddClassToJson() {
    return {
      'studentId': id,
      'classId': classId,
      'class_has_category': classHasCatId,
      'freeCard': freeCard,
      'status': activeStatus,
    };
  }

  Map<String, dynamic> studentPercentageToJson() {
    return {
      'studentId': id,
      'classId': classId,
    };
  }
}
