import 'package:equatable/equatable.dart';

class TodayClassesModel extends Equatable {
  final String? classStartMonth;
  final String? classEndMonth;
  final int? classStatus;
  final String? classStartTime;
  final String? classEndTime;
  final String? classDay;
  final String? className;
  final String? hallName;
  final String? customId;
  final String? initialName;
  final String? gradeName;
  final String? subjectName;
  final String? categoryName;

  const TodayClassesModel({
    this.classStartMonth,
    this.classEndMonth,
    this.classStatus,
    this.classStartTime,
    this.classEndTime,
    this.classDay,
    this.className,
    this.hallName,
    this.customId,
    this.initialName,
    this.gradeName,
    this.subjectName,
    this.categoryName,
  });

  // Convert JSON to TodayClassesModel
  factory TodayClassesModel.fromJson(Map<String, dynamic> json) {
    return TodayClassesModel(
      classStartMonth: json['classStartMonth'] as String?,
      classEndMonth: json['classEndMonth'] as String?,
      classStatus: int.parse(json['classStatus']),
      classStartTime: json['classStartTime'] as String?,
      classEndTime: json['classEndTime'] as String?,
      classDay: json['classDay'] as String?,
      className: json['className'] as String?,
      hallName: json['hall_name'] as String?,
      customId: json['customId'] as String?,
      initialName: json['initialName'] as String?,
      gradeName: json['gradeName'] as String?,
      subjectName: json['subjectName'] as String?,
      categoryName: json['categoryName'] as String?,
    );
  }

  // Convert TodayClassesModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'classStartMonth': classStartMonth,
      'classEndMonth': classEndMonth,
      'classStatus': classStatus,
      'classStartTime': classStartTime,
      'classEndTime': classEndTime,
      'classDay': classDay,
      'className': className,
      'hall_name': hallName,
      'customId': customId,
      'initialName': initialName,
      'gradeName': gradeName,
      'subjectName': subjectName,
      'categoryName': categoryName,
    };
  }

  // CopyWith method for immutability
  TodayClassesModel copyWith({
    String? classStartMonth,
    String? classEndMonth,
    int? classStatus,
    String? classStartTime,
    String? classEndTime,
    String? classDay,
    String? className,
    String? hallName,
    String? customId,
    String? initialName,
    String? gradeName,
    String? subjectName,
    String? categoryName,
  }) {
    return TodayClassesModel(
      classStartMonth: classStartMonth ?? this.classStartMonth,
      classEndMonth: classEndMonth ?? this.classEndMonth,
      classStatus: classStatus ?? this.classStatus,
      classStartTime: classStartTime ?? this.classStartTime,
      classEndTime: classEndTime ?? this.classEndTime,
      classDay: classDay ?? this.classDay,
      className: className ?? this.className,
      hallName: hallName ?? this.hallName,
      customId: customId ?? this.customId,
      initialName: initialName ?? this.initialName,
      gradeName: gradeName ?? this.gradeName,
      subjectName: subjectName ?? this.subjectName,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  @override
  List<Object?> get props => [
        classStartMonth,
        classEndMonth,
        classStatus,
        classStartTime,
        classEndTime,
        classDay,
        className,
        hallName,
        customId,
        initialName,
        gradeName,
        subjectName,
        categoryName,
      ];
}
