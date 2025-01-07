import 'package:equatable/equatable.dart';

class QuickImageModel extends Equatable {
  final int? imgId;
  final String? cusId;
  final String? quickImg;
  final int? gradeId;
  final String? gradeName;
  final int? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const QuickImageModel({
    this.imgId,
    this.cusId,
    this.quickImg,
    this.gradeId,
    this.gradeName,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        imgId,
        cusId,
        quickImg,
        gradeId,
        gradeName,
        isActive,
        createdAt,
        updatedAt
      ];

  QuickImageModel copyWith({
    int? imgId,
    String? cusId,
    int? gradeId,
    String? gradeName,
    int? isActive,
    String? quickImg,
  }) {
    return QuickImageModel(
      imgId: imgId ?? this.imgId,
      cusId: cusId ?? this.cusId,
      gradeId: gradeId ?? this.gradeId,
      gradeName: gradeName ?? this.gradeName,
      isActive: isActive ?? this.isActive,
      quickImg: quickImg ?? this.quickImg,
    );
  }

  factory QuickImageModel.fromJson(Map<String, dynamic> json) {
    return QuickImageModel(
      imgId: json['id'] is String ? int.parse(json['id']) : json['id'] as int?,
      cusId: json['custom_id'] as String?,
      quickImg: json['quick_img'] ?? '',
      gradeId: json['grade_id'] is String
          ? int.parse(json['grade_id'])
          : json['grade_id'] as int?,
      gradeName: json['gradeName'] as String?,
      isActive: json['is_active'] is String
          ? int.parse(json['is_active'])
          : json['is_active'] as int?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quick_img': quickImg,
      'grade_id': gradeId,
      'is_active': isActive
      //'created_at': createdAt!.toIso8601String(),
    };
  }
}
