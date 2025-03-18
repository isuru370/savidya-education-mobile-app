import 'package:equatable/equatable.dart';

class QrReadStudentModelClass extends Equatable {
  final String? studentCustomId;
  final int? classHasCatId;
  final int? studentClassFreeCard;
  final int? classAttendanceId;
  final int? studentStudentClassId;
  final int? studentId;
  final String? initialName;
  final String? mobileNo;
  final String? guardianMobile;
  final int? freeCard;
  final String? imageUrl;
  final double? fees;
  final int? classCategoryId;
  final String? categoryName;
  final String? className;

  //tute
  final String? tuteFor;

  const QrReadStudentModelClass(
      {this.studentCustomId,
      this.classHasCatId,
      this.studentClassFreeCard,
      this.classAttendanceId,
      this.studentStudentClassId,
      this.studentId,
      this.initialName,
      this.mobileNo,
      this.guardianMobile,
      this.freeCard,
      this.imageUrl,
      this.fees,
      this.classCategoryId,
      this.categoryName,
      this.className,
      this.tuteFor});

  // fromJson method
  factory QrReadStudentModelClass.fromJson(Map<String, dynamic> json) {
    return QrReadStudentModelClass(
      studentId: _parseInt(json['studentId']),
      studentStudentClassId: _parseInt(json['studentStudentClassId']),
      classHasCatId: json['classCategoryHasStudentClassId'] != null
          ? _parseInt(json['classCategoryHasStudentClassId'])
          : _parseInt(json['classCategoryHasStudentClassId']),
      studentClassFreeCard: _parseInt(json['classFreeCard']),
      initialName: json['initialName'] as String?,
      mobileNo: json['mobileNo'] as String?,
      guardianMobile: json['guardianMobile'] as String?,
      freeCard: _parseInt(json['freeCard']),
      imageUrl: json['imageUrl'] as String?,
      fees: _parseDouble(json['fees']),
      classCategoryId: _parseInt(json['catId']),
      categoryName: json['categoryName'] ?? "",
      className: json['className'] ?? "",
    );
  }

  factory QrReadStudentModelClass.rearPaymentJson(Map<String, dynamic> json) {
    return QrReadStudentModelClass(
      studentId: _parseInt(json['student_id']),
      studentStudentClassId: _parseInt(json['studentStudentClassId']),
      studentClassFreeCard: _parseInt(json["classFreeCard"]),
      classHasCatId: _parseInt(json['classHasCategory']),
      initialName: json['initialName'] as String?,
      mobileNo: json['mobileNo'] as String?,
      guardianMobile: json['guardianMobile'] as String?,
      imageUrl: json['ImageUrl'] as String?,
      classCategoryId: _parseInt(json['catId']),
      fees: _parseDouble(json['fees']),
      categoryName: json['categoryName'] ?? "",
      className: json['className'] ?? "",
    );
  }

  // copyWith method
  QrReadStudentModelClass copyWith({
    String? studentCustomId,
    int? classHasCatId,
    int? classAttendanceId,
    int? studentStudentClassId,
    int? studentId,
    String? initialName,
    String? mobileNo,
    String? guardianMobile,
    int? freeCard,
    String? imageUrl,
    double? fees,
    int? classCategoryId,
    String? categoryName,
    String? className,
  }) {
    return QrReadStudentModelClass(
      studentCustomId: studentCustomId ?? this.studentCustomId,
      classHasCatId: classHasCatId ?? this.classHasCatId,
      classAttendanceId: classAttendanceId ?? this.classAttendanceId,
      studentStudentClassId:
          studentStudentClassId ?? this.studentStudentClassId,
      studentId: studentId ?? this.studentId,
      initialName: initialName ?? this.initialName,
      mobileNo: mobileNo ?? this.mobileNo,
      guardianMobile: guardianMobile ?? this.guardianMobile,
      freeCard: freeCard ?? this.freeCard,
      imageUrl: imageUrl ?? this.imageUrl,
      fees: fees ?? this.fees,
      classCategoryId: classCategoryId ?? this.classCategoryId,
      categoryName: categoryName ?? this.categoryName,
      className: className ?? this.className,
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'studentCusId': studentCustomId,
      'classCatId': classHasCatId,
      'studentStudentClassId': studentStudentClassId,
      'studentId': studentId,
      'classAttendanceId': classAttendanceId,
      'initialName': initialName,
      'mobileNo': mobileNo,
      'guardianMobile': guardianMobile,
      'freeCard': freeCard,
      'imageUrl': imageUrl,
      'fees': fees,
      'classCategoryId': classCategoryId,
      'categoryName': categoryName,
      'className': className,
    };
  }

  Map<String, dynamic> markJson() {
    return {
      'studentStudentStudentClassId': studentStudentClassId,
      'studentId': studentId,
      'classAttendanceId': classAttendanceId,
      'tuteFor': tuteFor,
      'class_category_id': classCategoryId,
    };
  }

  @override
  List<Object?> get props => [
        studentCustomId,
        classHasCatId,
        studentClassFreeCard,
        classAttendanceId,
        studentStudentClassId,
        studentId,
        initialName,
        mobileNo,
        guardianMobile,
        freeCard,
        imageUrl,
        fees,
        classCategoryId,
        categoryName,
        className,
        tuteFor,
      ];

  // Safe parsing methods
  static int? _parseInt(dynamic value) {
    if (value is int) {
      return value; // Already an integer
    } else if (value is String) {
      return int.tryParse(value); // Attempt to parse if it's a string
    }
    return null; // Return null if it's neither an int nor a string
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null; // Handle null value
    try {
      return value is double ? value : double.parse(value.toString());
    } catch (_) {
      return null; // Return null if parsing fails
    }
  }
}

class QrReadClassCatModelClass extends Equatable {
  final int? studentClassId;
  final String? categoryName;

  const QrReadClassCatModelClass({
    this.studentClassId,
    this.categoryName,
  });

  // fromJson method
  factory QrReadClassCatModelClass.fromJson(Map<String, dynamic> json) {
    return QrReadClassCatModelClass(
      studentClassId: QrReadStudentModelClass._parseInt(json['studentClassId']),
      categoryName: json['categoryName'] as String?,
    );
  }

  // copyWith method
  QrReadClassCatModelClass copyWith({
    int? studentClassId,
    String? categoryName,
  }) {
    return QrReadClassCatModelClass(
      studentClassId: studentClassId ?? this.studentClassId,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'studentClassId': studentClassId,
      'categoryName': categoryName,
    };
  }

  @override
  List<Object?> get props => [studentClassId, categoryName];
}

class QrReadStudentPaymentModel extends Equatable {
  final DateTime? paymentDate;
  final String? paymentFor;

  const QrReadStudentPaymentModel({
    this.paymentDate,
    this.paymentFor,
  });

  // fromJson method
  factory QrReadStudentPaymentModel.fromJson(Map<String, dynamic> json) {
    return QrReadStudentPaymentModel(
      paymentDate: json['payment_date'] != null
          ? DateTime.tryParse(json['payment_date'])
          : null,
      paymentFor: json['payment_for'] ?? "",
    );
  }

  // copyWith method
  QrReadStudentPaymentModel copyWith({
    DateTime? paymentDate,
    String? paymentFor,
  }) {
    return QrReadStudentPaymentModel(
      paymentDate: paymentDate ?? this.paymentDate,
      paymentFor: paymentFor ?? this.paymentFor,
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'payment_date':
          paymentDate?.toIso8601String(), // Convert DateTime to String
      'payment_for': paymentFor,
    };
  }

  @override
  List<Object?> get props => [paymentDate, paymentFor];
}
