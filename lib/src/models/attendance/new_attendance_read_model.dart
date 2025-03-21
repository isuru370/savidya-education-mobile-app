import 'package:equatable/equatable.dart';

class NewAttendanceReadModel extends Equatable {
  final int studentId;
  final String cusId;
  final String initialName;
  final String imgUrl;
  final String whatsappMobile;
  final String guardianMobile;
  final int isFreeCard;
  final int? classCatId;

  // Making these fields nullable
  final String? className;
  final String? gradeName;
  final String? subjectName;
  final String? categoryName;
  final double? fees;
  final int? studentStudentClassId;
  final DateTime? lastPaymentDate;
  final String? lastPaymentFor;
  final double? amount;
  final int? classAttendanceId;

  const NewAttendanceReadModel({
    required this.studentId,
    required this.cusId,
    required this.initialName,
    required this.imgUrl,
    required this.whatsappMobile,
    required this.guardianMobile,
    required this.isFreeCard,
    this.classCatId,
    this.className,
    this.gradeName,
    this.subjectName,
    this.categoryName,
    this.fees,
    this.studentStudentClassId,
    this.lastPaymentDate,
    this.lastPaymentFor,
    this.amount,
    this.classAttendanceId,
  });

  // From JSON constructor to handle null and create instances
  factory NewAttendanceReadModel.fromJson(Map<String, dynamic> json) {
    return NewAttendanceReadModel(
      studentId: json['studentId'] != null
          ? int.tryParse(json['studentId'].toString()) ?? 0
          : 0,
      cusId: json['cusId'] ?? '', // Empty string if null
      initialName: json['lname'] ?? '', // Empty string if null
      imgUrl: json['img_url'] ?? '', // Empty string if null
      whatsappMobile: json['whatsapp_mobile'] ?? '', // Empty string if null
      guardianMobile: json['guardian_mobile'] ?? '', // Empty string if null
      className: json['class_name'], // Nullable field
      gradeName: json['grade_name'], // Nullable field
      subjectName: json['subject_name'], // Nullable field
      classCatId: json['class_cat_id'] != null
          ? int.tryParse(json['class_cat_id'].toString()) ?? 0
          : 0,
      categoryName: json['category_name'], // Nullable field
      fees: json['fees'] != null
          ? double.tryParse(json['fees'].toString()) ?? 0.00
          : 0.00, // Default to 0.00 if null
      studentStudentClassId: json['studentStudentClassId'] != null
          ? int.tryParse(json['studentStudentClassId'].toString()) ?? 0
          : 0, // Default to 0 if null
      isFreeCard: json['is_free_card'] is int
          ? json['is_free_card']
          : int.tryParse(json['is_free_card'].toString()) ?? 0, // Fix here

      lastPaymentDate: json['lastPaymentDate'] != null
          ? DateTime.tryParse(json['lastPaymentDate'])
          : null, // Nullable DateTime
      lastPaymentFor: json['lastPaymentFor'], // Nullable field
      amount: json['amount'] != null
          ? double.tryParse(json['amount'].toString()) ?? 0.00
          : 0.00, // Default to 0.00 if null
      classAttendanceId: json['classAttendanceId'] != null
          ? int.tryParse(json['classAttendanceId'].toString()) ?? 0
          : 0, // Default to 0 if null
    );
  }

  // Copy with method for creating a modified instance
  NewAttendanceReadModel copyWith({
    int? studentId,
    String? cusId,
    String? initialName,
    String? imgUrl,
    String? whatsappMobile,
    String? guardianMobile,
    String? className,
    String? gradeName,
    String? subjectName,
    String? categoryName,
    double? fees,
    int? studentStudentClassId,
    int? isFreeCard,
    DateTime? lastPaymentDate,
    String? lastPaymentFor,
    double? amount,
    int? classAttendanceId,
  }) {
    return NewAttendanceReadModel(
      studentId: studentId ?? this.studentId,
      cusId: cusId ?? this.cusId,
      initialName: initialName ?? this.initialName,
      imgUrl: imgUrl ?? this.imgUrl,
      whatsappMobile: whatsappMobile ?? this.whatsappMobile,
      guardianMobile: guardianMobile ?? this.guardianMobile,
      className: className ?? this.className,
      gradeName: gradeName ?? this.gradeName,
      subjectName: subjectName ?? this.subjectName,
      categoryName: categoryName ?? this.categoryName,
      fees: fees ?? this.fees,
      studentStudentClassId:
          studentStudentClassId ?? this.studentStudentClassId,
      isFreeCard: isFreeCard ?? this.isFreeCard,
      lastPaymentDate: lastPaymentDate ?? this.lastPaymentDate,
      lastPaymentFor: lastPaymentFor ?? this.lastPaymentFor,
      amount: amount ?? this.amount,
      classAttendanceId: classAttendanceId ?? this.classAttendanceId,
    );
  }

  @override
  List<Object?> get props => [
        studentId,
        cusId,
        initialName,
        imgUrl,
        whatsappMobile,
        guardianMobile,
        className,
        gradeName,
        subjectName,
        categoryName,
        fees,
        studentStudentClassId,
        isFreeCard,
        lastPaymentDate,
        lastPaymentFor,
        amount,
        classAttendanceId,
        classCatId,
      ];
}
