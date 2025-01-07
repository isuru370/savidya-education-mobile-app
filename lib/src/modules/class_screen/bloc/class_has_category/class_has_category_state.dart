part of 'class_has_category_bloc.dart';

sealed class ClassHasCategoryState extends Equatable {
  const ClassHasCategoryState();

  @override
  List<Object> get props => [];
}

final class ClassHasCategoryInitial extends ClassHasCategoryState {}

final class ClassHasCategoryProcess extends ClassHasCategoryState {}

final class ClassHasCategoryFailure extends ClassHasCategoryState {
  final String failureMessage;
  const ClassHasCategoryFailure({required this.failureMessage});
  @override
  List<Object> get props => [failureMessage];
}

final class ClassHasCategorySuccess extends ClassHasCategoryState {
  final String successMessage;
  const ClassHasCategorySuccess({required this.successMessage});
  @override
  List<Object> get props => [successMessage];
}

final class GetClassHasCategorySuccess extends ClassHasCategoryState {
  final List<ClassHasCategoryModelClass> allClassHasCatList;
  const GetClassHasCategorySuccess({required this.allClassHasCatList});
  @override
  List<Object> get props => [allClassHasCatList];
}

final class ClassTheoryAndRevisionSuccess extends ClassHasCategoryState {
  final List<ClassHasCategoryModelClass> theoryAnRevisionList;
  const ClassTheoryAndRevisionSuccess({required this.theoryAnRevisionList});

  @override
  List<Object> get props => [theoryAnRevisionList];
}

final class GetUniqueClassHasCatSuccess extends ClassHasCategoryState {
  final List<ClassHasCategoryModelClass> uniqueClassHasCatList;
  const GetUniqueClassHasCatSuccess({required this.uniqueClassHasCatList});

  @override
  List<Object> get props => [uniqueClassHasCatList];
}
