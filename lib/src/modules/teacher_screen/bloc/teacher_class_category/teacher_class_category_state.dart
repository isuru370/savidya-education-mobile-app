part of 'teacher_class_category_bloc.dart';

@immutable
sealed class TeacherClassCategoryState extends Equatable {
  const TeacherClassCategoryState();

  @override
  List<Object?> get props => [];
}

final class TeacherClassCategoryInitial extends TeacherClassCategoryState {}

final class TeacherClassCategoryProcess extends TeacherClassCategoryState {}

final class TeacherClassCategoryFailure extends TeacherClassCategoryState {
  final String failureMessage;
  const TeacherClassCategoryFailure({required this.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}

final class TeacherClassCategorySuccess extends TeacherClassCategoryState {
  final List<TeacherClassCategoryModel> teacherClassCategoryModel;
  const TeacherClassCategorySuccess({required this.teacherClassCategoryModel});

  @override
  List<Object?> get props => [teacherClassCategoryModel];
}
