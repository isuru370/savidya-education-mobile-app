import 'package:equatable/equatable.dart';

class PaymentMonthlyReportModel extends Equatable {
  final int studentId;
  final String customId;
  final String lname;
  final String imgUrl;
  final String whatsappMobile;
  final String? parentMobile;
  final String studentStatus;
  final String createdAt;
  final int classRecordId;
  final int classCategoryHasStudentClassId;
  final int classFreeCrad;
  final String? paymentDate;
  final double? amount;
  final String? paymentFor;
  final String paymentStatus;

  const PaymentMonthlyReportModel({
    required this.studentId,
    required this.customId,
    required this.lname,
    required this.imgUrl,
    required this.whatsappMobile,
    required this.parentMobile,
    required this.studentStatus,
    required this.createdAt,
    required this.classRecordId,
    required this.classCategoryHasStudentClassId,
    required this.classFreeCrad,
    this.paymentDate,
    this.amount,
    this.paymentFor,
    required this.paymentStatus,
  });

  // fromJson
  factory PaymentMonthlyReportModel.fromJson(Map<String, dynamic> json) {
    return PaymentMonthlyReportModel(
      studentId: _parseInt(json['student_id']),
      customId: json['custom_id'],
      lname: json['lname'],
      imgUrl: json['img_url'],
      whatsappMobile: json['whatsapp_mobile'],
      parentMobile: json['guardian_mobile'],
      studentStatus: json['student_status'],
      createdAt: json['created_at'],
      classRecordId: _parseInt(json['class_record_id']),
      classCategoryHasStudentClassId:
          _parseInt(json['class_category_has_student_class_id']),
      classFreeCrad:
          _parseInt(json['is_free_card']),
      paymentDate: json['payment_date'],
      amount: _parseAmount(json['amount']),
      paymentFor: json['payment_for'],
      paymentStatus: json['payment_status'],
    );
  }

  // Static helper method to parse integers from dynamic values
  static int _parseInt(dynamic value) {
    if (value is String) {
      return int.tryParse(value) ?? 0; // Default to 0 if parsing fails
    }
    return value as int? ?? 0; // Default to 0 if value is null
  }

  // Helper method to parse amount, handling both String and num types
  static double? _parseAmount(dynamic value) {
    if (value == null) return null;
    if (value is String) {
      return double.tryParse(value); // Try parsing as a double
    }
    return value is num
        ? value.toDouble()
        : null; // If it's already a num, convert to double
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'custom_id': customId,
      'lname': lname,
      'img_url': imgUrl,
      'whatsapp_mobile': whatsappMobile,
      'student_status': studentStatus,
      'created_at': createdAt,
      'class_record_id': classRecordId,
      'class_category_has_student_class_id': classCategoryHasStudentClassId,
      'payment_date': paymentDate,
      'amount': amount,
      'payment_for': paymentFor,
      'payment_status': paymentStatus,
    };
  }

  // copyWith
  PaymentMonthlyReportModel copyWith({
    int? studentId,
    String? customId,
    String? lname,
    String? imgUrl,
    String? whatsappMobile,
    String? parentMobile,
    String? studentStatus,
    String? createdAt,
    int? classRecordId,
    int? classCategoryHasStudentClassId,
    int? classFreeCard,
    String? paymentDate,
    double? amount,
    String? paymentFor,
    String? paymentStatus,
  }) {
    return PaymentMonthlyReportModel(
      studentId: studentId ?? this.studentId,
      customId: customId ?? this.customId,
      lname: lname ?? this.lname,
      imgUrl: imgUrl ?? this.imgUrl,
      whatsappMobile: whatsappMobile ?? this.whatsappMobile,
      parentMobile: parentMobile ?? this.parentMobile,
      studentStatus: studentStatus ?? this.studentStatus,
      createdAt: createdAt ?? this.createdAt,
      classRecordId: classRecordId ?? this.classRecordId,
      classCategoryHasStudentClassId:
          classCategoryHasStudentClassId ?? this.classCategoryHasStudentClassId,
      classFreeCrad: classFreeCard ?? classFreeCrad,
      paymentDate: paymentDate ?? this.paymentDate,
      amount: amount ?? this.amount,
      paymentFor: paymentFor ?? this.paymentFor,
      paymentStatus: paymentStatus ?? this.paymentStatus,
    );
  }

  @override
  List<Object?> get props => [
        studentId,
        customId,
        lname,
        imgUrl,
        whatsappMobile,
        parentMobile,
        studentStatus,
        createdAt,
        classRecordId,
        classCategoryHasStudentClassId,
        classFreeCrad,
        paymentDate,
        amount,
        paymentFor,
        paymentStatus,
      ];
}
