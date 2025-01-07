part of 'class_halls_bloc.dart';

sealed class ClassHallsState extends Equatable {
  const ClassHallsState();

  @override
  List<Object> get props => [];
}

final class ClassHallsInitial extends ClassHallsState {}

final class GetClassHallsFailure extends ClassHallsState {
  final String failureMessage;
  const GetClassHallsFailure({required this.failureMessage});

   @override
  List<Object> get props => [failureMessage];
}

final class GetClassHallsSuccess extends ClassHallsState {
  final List<ClassHalleModelClass> classHallList;
  const GetClassHallsSuccess({required this.classHallList});

   @override
  List<Object> get props => [classHallList];
}
