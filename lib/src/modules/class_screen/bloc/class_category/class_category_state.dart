part of 'class_category_bloc.dart';

sealed class ClassCategoryState extends Equatable {
  const ClassCategoryState();

  @override
  List<Object> get props => [];
}

final class ClassCategoryInitial extends ClassCategoryState {}

final class ClassCategoryProcess extends ClassCategoryState {}

final class ClassCategoryFailure extends ClassCategoryState {
  final String failureMessage;
  const ClassCategoryFailure({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}

final class ClassCategorySuccess extends ClassCategoryState {
  final List<ClassCategoryModelClass> classCategoryList;
  const ClassCategorySuccess({required this.classCategoryList});

  @override
  List<Object> get props => [classCategoryList];
}
