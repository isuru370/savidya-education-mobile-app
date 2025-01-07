part of 'class_has_category_bloc.dart';

sealed class ClassHasCategoryEvent extends Equatable {
  const ClassHasCategoryEvent();

  @override
  List<Object> get props => [];
}

final class InsertClassHasCategory extends ClassHasCategoryEvent {
  final CategoryHasClassModelClass classHasCatModelClass;
  const InsertClassHasCategory({required this.classHasCatModelClass});

  @override
  List<Object> get props => [classHasCatModelClass];
}

final class GetAllClassHasCategory extends ClassHasCategoryEvent {}

final class ClassHasCategoryClassEvent extends ClassHasCategoryEvent {}

final class GetUniqueClassHasCatEvent extends ClassHasCategoryEvent {
  final int classId;
  const GetUniqueClassHasCatEvent({required this.classId});

  @override
  List<Object> get props => [classId];
}
