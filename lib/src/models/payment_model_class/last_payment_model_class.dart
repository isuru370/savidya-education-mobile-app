import 'package:equatable/equatable.dart';

class LastPaymentModelClass extends Equatable {
  final String studentStudentClassId;
  final int classFreeCard;
  final String classHasCategory;
  final String studentId;
  final String initialName;
  final String mobileNo;
  final String guardianMobile;
  final String imageUrl;
  final String catId;
  final String fees;
  final String categoryName;
  final String className;
  final String gradeName;
  final String gradeId;
  final String? lastPaymentDate; // Nullable to handle missing dates
  final String? lastPaymentFor; // Nullable to handle missing data

  const LastPaymentModelClass({
    required this.studentStudentClassId,
    required this.classFreeCard,
    required this.classHasCategory,
    required this.studentId,
    required this.initialName,
    required this.mobileNo,
    required this.guardianMobile,
    required this.imageUrl,
    required this.catId,
    required this.fees,
    required this.categoryName,
    required this.className,
    required this.gradeName,
    required this.gradeId,
    this.lastPaymentDate,
    this.lastPaymentFor,
  });

  // Factory constructor for creating an instance from JSON
  factory LastPaymentModelClass.fromJson(Map<String, dynamic> json) {
    return LastPaymentModelClass(
      studentStudentClassId: json['studentStudentClassId']?.toString() ??
          '', // Ensure it's a String
      classFreeCard: json['classFreeCard'] is int
          ? json['classFreeCard']
          : int.tryParse(json['classFreeCard'].toString()) ??
              0, // Safely handle int or String
      classHasCategory:
          json['classHasCategory']?.toString() ?? '', // Ensure it's a String
      studentId: json['student_id']?.toString() ?? '', // Ensure it's a String
      initialName:
          json['initialName']?.toString() ?? '', // Ensure it's a String
      mobileNo: json['mobileNo']?.toString() ?? '', // Ensure it's a String
      guardianMobile:
          json['guardianMobile']?.toString() ?? '', // Ensure it's a String
      imageUrl: json['ImageUrl']?.toString() ?? '', // Ensure it's a String
      catId: json['catId']?.toString() ?? '', // Ensure it's a String
      fees: json['fees']?.toString() ?? '', // Ensure it's a String
      categoryName:
          json['categoryName']?.toString() ?? '', // Ensure it's a String
      className: json['className']?.toString() ?? '', // Ensure it's a String
      gradeName: json['gradeName']?.toString() ?? '', // Ensure it's a String
      gradeId: json['gradeId']?.toString() ?? '', // Ensure it's a String
      lastPaymentDate: json['lastPaymentDate']?.toString(), // Nullable String
      lastPaymentFor: json['lastPaymentFor']?.toString(), // Nullable String
    );
  }

  // CopyWith method for creating a new instance with modified values
  LastPaymentModelClass copyWith({
    String? studentStudentClassId,
    int? classFreeCard,
    String? classHasCategory,
    String? studentId,
    String? initialName,
    String? mobileNo,
    String? guardianMobile,
    String? imageUrl,
    String? catId,
    String? fees,
    String? categoryName,
    String? className,
    String? gradeName,
    String? gradeId,
    String? lastPaymentDate,
    String? lastPaymentFor,
  }) {
    return LastPaymentModelClass(
      studentStudentClassId:
          studentStudentClassId ?? this.studentStudentClassId,
      classFreeCard: classFreeCard ?? this.classFreeCard,
      classHasCategory: classHasCategory ?? this.classHasCategory,
      studentId: studentId ?? this.studentId,
      initialName: initialName ?? this.initialName,
      mobileNo: mobileNo ?? this.mobileNo,
      guardianMobile: guardianMobile ?? this.guardianMobile,
      imageUrl: imageUrl ?? this.imageUrl,
      catId: catId ?? this.catId,
      fees: fees ?? this.fees,
      categoryName: categoryName ?? this.categoryName,
      className: className ?? this.className,
      gradeName: gradeName ?? this.gradeName,
      gradeId: gradeId ?? this.gradeId,
      lastPaymentDate: lastPaymentDate ?? this.lastPaymentDate,
      lastPaymentFor: lastPaymentFor ?? this.lastPaymentFor,
    );
  }

  @override
  List<Object?> get props => [
        studentStudentClassId,
        classFreeCard,
        classHasCategory,
        studentId,
        initialName,
        mobileNo,
        guardianMobile,
        imageUrl,
        catId,
        fees,
        categoryName,
        className,
        gradeName,
        gradeId,
        lastPaymentDate,
        lastPaymentFor,
      ];
}
