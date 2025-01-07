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
  final String? lastPaymentFor;  // Nullable to handle missing data

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
      studentStudentClassId: json['studentStudentClassId'] as String,
      classFreeCard: int.parse(json['classFreeCard']),
      classHasCategory: json['classHasCategory'] as String,
      studentId: json['student_id'] as String,
      initialName: json['initialName'] as String,
      mobileNo: json['mobileNo'] as String,
      guardianMobile: json['guardianMobile'] as String,
      imageUrl: json['ImageUrl'] as String,
      catId: json['catId'] as String,
      fees: json['fees'] as String,
      categoryName: json['categoryName'] as String,
      className: json['className'] as String,
      gradeName: json['gradeName'] as String,
      gradeId: json['gradeId'] as String,
      lastPaymentDate: json['lastPaymentDate'] as String?,
      lastPaymentFor: json['lastPaymentFor'] as String?,
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
