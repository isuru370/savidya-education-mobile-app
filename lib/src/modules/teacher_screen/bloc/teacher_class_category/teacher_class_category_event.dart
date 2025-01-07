part of 'teacher_class_category_bloc.dart';

@immutable
sealed class TeacherClassCategoryEvent extends Equatable {
  const TeacherClassCategoryEvent();

  @override
  List<Object?> get props => [];
}

final class GetTeacherClassCategoryEvent extends TeacherClassCategoryEvent {
  final int teacherClassId;
  const GetTeacherClassCategoryEvent({required this.teacherClassId});

  @override
  List<Object?> get props => [teacherClassId];
}
