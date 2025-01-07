import 'package:equatable/equatable.dart';

class StudentsInTheClassModel extends Equatable {
  final int studentStudentClassId;
  final int studentId;
  final int studentHasCatId;
  final int studentStates; // This should remain as an integer
  final DateTime classJoinDate;
  final int studentFreeCard; // This should be a boolean
  final String customId;
  final String initialName;
  final String whatsappNo;
  final String parentNo;
  final String imgUrl;

  const StudentsInTheClassModel({
    required this.studentStudentClassId,
    required this.studentId,
    required this.studentHasCatId,
    required this.studentStates,
    required this.classJoinDate,
    required this.studentFreeCard,
    required this.customId,
    required this.initialName,
    required this.whatsappNo,
    required this.parentNo,
    required this.imgUrl,
  });

  @override
  List<Object?> get props => [
        studentStudentClassId,
        studentId,
        studentHasCatId,
        studentStates,
        classJoinDate,
        studentFreeCard,
        customId,
        initialName,
        whatsappNo,
        parentNo,
        imgUrl,
      ];

  // Factory constructor to create an instance from JSON
  factory StudentsInTheClassModel.fromJson(Map<String, dynamic> json) {
    return StudentsInTheClassModel(
      studentStudentClassId:
          int.tryParse(json['studentStudentClassId'].toString()) ?? 0,
      studentId: int.tryParse(json['studentId'].toString()) ?? 0,
      studentHasCatId: int.tryParse(json['studentHasCatId'].toString()) ?? 0,
      studentStates: int.parse(json['studentStates']), // Ensure it's an integer
      classJoinDate:
          DateTime.tryParse(json['classJoinDate'] ?? '') ?? DateTime(1970),
      studentFreeCard: int.parse(json['studentFreeCard']), // Convert to boolean
      customId: json['customId'] ?? '',
      initialName: json['initialName'] ?? '',
      whatsappNo: json['whatsappNo'] ?? '',
      parentNo: json['parentNo'] ?? '',
      imgUrl: json['imgUrl'] ?? '',
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'studentStudentClassId': studentStudentClassId,
      'studentId': studentId,
      'studentHasCatId': studentHasCatId,
      'studentStates': studentStates,
      'classJoinDate': classJoinDate.toIso8601String(),
      'studentFreeCard':
          studentFreeCard , // Convert boolean to integer (1 or 0)
      'customId': customId,
      'initialName': initialName,
      'whatsappNo': whatsappNo,
      'parentNo': parentNo,
      'imgUrl': imgUrl,
    };
  }

  // CopyWith method for immutability
  StudentsInTheClassModel copyWith({
    int? studentStudentClassId,
    int? studentId,
    int? studentHasCatId,
    int? studentStates, // Keep it as int
    DateTime? classJoinDate,
    int? studentFreeCard, // Keep it as boolean
    String? customId,
    String? initialName,
    String? whatsappNo,
    String? parentNo,
    String? imgUrl,
  }) {
    return StudentsInTheClassModel(
      studentStudentClassId:
          studentStudentClassId ?? this.studentStudentClassId,
      studentId: studentId ?? this.studentId,
      studentHasCatId: studentHasCatId ?? this.studentHasCatId,
      studentStates: studentStates ?? this.studentStates,
      classJoinDate: classJoinDate ?? this.classJoinDate,
      studentFreeCard: studentFreeCard ?? this.studentFreeCard,
      customId: customId ?? this.customId,
      initialName: initialName ?? this.initialName,
      whatsappNo: whatsappNo ?? this.whatsappNo,
      parentNo: parentNo ?? this.parentNo,
      imgUrl: imgUrl ?? this.imgUrl,
    );
  }
}
