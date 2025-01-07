import 'package:equatable/equatable.dart';

class CategoryHasClassModelClass extends Equatable {
  final int? categoryHasClassId;
  final double? fees;
  final int? classId;
  final String? className;
  final String? classDayNames;
  final String? startTime;
  final String? endTime;
  final int? isActive;
  final int? isOngoing;
  final int? teacherId;
  final int? subjectId;
  final int? gradeId;
  final int? categoryId;
  final String? categoryName;
  final DateTime? createAt;
  final DateTime? updateAt;

  const CategoryHasClassModelClass({
    this.categoryHasClassId,
    this.fees,
    this.classId,
    this.className,
    this.classDayNames,
    this.startTime,
    this.endTime,
    this.isActive,
    this.isOngoing,
    this.teacherId,
    this.subjectId,
    this.gradeId,
    this.categoryId,
    this.categoryName,
    this.createAt,
    this.updateAt,
  });

  CategoryHasClassModelClass copyWith({
    int? categoryHasClassId,
    double? fees,
    int? classId,
    String? className,
    String? classDayNames,
    String? startTime,
    String? endTime,
    int? isActive,
    int? isOngoing,
    int? teacherId,
    int? subjectId,
    int? gradeId,
    int? categoryId,
    String? categoryName,
    DateTime? createAt,
    DateTime? updateAt,
  }) {
    return CategoryHasClassModelClass(
      categoryHasClassId: categoryHasClassId ?? this.categoryHasClassId,
      fees: fees ?? this.fees,
      classId: classId ?? this.classId,
      className: className ?? this.className,
      classDayNames: classDayNames ?? this.classDayNames,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isActive: isActive ?? this.isActive,
      isOngoing: isOngoing ?? this.isOngoing,
      teacherId: teacherId ?? this.teacherId,
      subjectId: subjectId ?? this.subjectId,
      gradeId: gradeId ?? this.gradeId,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  factory CategoryHasClassModelClass.fromJson(Map<String, dynamic> json) {
    return CategoryHasClassModelClass(
      categoryHasClassId: json['categoryHasClassId'] is String
          ? int.parse(json['categoryHasClassId'])
          : json['categoryHasClassId'] as int?,
      fees: json['fees'] is String
          ? double.parse(json['fees'])
          : json['fees'] as double?,
      classId: json['classId'] is String
          ? int.parse(json['classId'])
          : json['classId'] as int?,
      className: json['className'] as String?,
      classDayNames: json['classDayNames'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      isActive: json['isActive'] is String
          ? int.parse(json['isActive'])
          : json['isActive'] as int?,
      isOngoing: json['isOngoing'] is String
          ? int.parse(json['isOngoing'])
          : json['isOngoing'] as int?,
      teacherId: json['teacherId'] is String
          ? int.parse(json['teacherId'])
          : json['teacherId'] as int?,
      subjectId: json['subjectId'] is String
          ? int.parse(json['subjectId'])
          : json['subjectId'] as int?,
      gradeId: json['gradeId'] is String
          ? int.parse(json['gradeId'])
          : json['gradeId'] as int?,
      categoryId: json['categoryId'] is String
          ? int.parse(json['categoryId'])
          : json['categoryId'] as int?,
      categoryName: json['categoryName'] as String?,
      createAt: json['createAt'] != null
          ? DateTime.parse(json['createAt'] as String)
          : null,
      updateAt: json['updateAt'] != null
          ? DateTime.parse(json['updateAt'] as String)
          : null,
    );
  }

  factory CategoryHasClassModelClass.fromJsonCategory(
      Map<String, dynamic> json) {
    return CategoryHasClassModelClass(
      classId: json['classId'] is String
          ? int.parse(json['classId'])
          : json['classId'] as int?,
      className: json['className'] as String?,
      classDayNames: json['daysName'] as String?,
      fees: json['classFees'] is String
          ? double.parse(json['classFees'])
          : json['classFees'] as double?,
      categoryHasClassId: json['classHasCatId'] is String
          ? int.parse(json['classHasCatId'])
          : json['classHasCatId'] as int?,
      categoryId: json['categoryId'] is String
          ? int.parse(json['categoryId'])
          : json['categoryId'] as int?,
      categoryName: json['categoryName'] as String?,
      createAt: json['createAt'] != null
          ? DateTime.parse(json['createAt'] as String)
          : null,
      updateAt: json['updateAt'] != null
          ? DateTime.parse(json['updateAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fees': fees,
      'classId': classId,
      'categoryId': categoryId,
    };
  }

  @override
  List<Object?> get props => [
        categoryHasClassId,
        fees,
        classId,
        className,
        classDayNames,
        startTime,
        endTime,
        isActive,
        isOngoing,
        teacherId,
        subjectId,
        gradeId,
        categoryId,
        categoryName,
        createAt,
        updateAt,
      ];
}
