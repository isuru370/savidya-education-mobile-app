part of 'class_bloc_bloc.dart';

sealed class ClassBlocState extends Equatable {
  const ClassBlocState();

  @override
  List<Object> get props => [];
}

final class ClassBlocInitial extends ClassBlocState {}

class ClassDataProcess extends ClassBlocState {}

class ClassDataSuccess extends ClassBlocState {
  final String successMessage;
  final String classId;
  const ClassDataSuccess({
    required this.successMessage,
    required this.classId,
  });

  @override
  List<Object> get props => [successMessage, classId];
}

class ClassDataUpdated extends ClassBlocState {
  final String updateMessage;
  const ClassDataUpdated({
    required this.updateMessage,
  });

  @override
  List<Object> get props => [updateMessage];
}

class GetActiveClassSuccess extends ClassBlocState {
  final List<ClassScheduleModelClass> studentModelClass;
  const GetActiveClassSuccess({
    required this.studentModelClass,
  });
  @override
  List<Object> get props => [studentModelClass];
}

class GetOngoingSuccess extends ClassBlocState {
  final List<ClassScheduleModelClass> studentModelClass;
  const GetOngoingSuccess({
    required this.studentModelClass,
  });
  @override
  List<Object> get props => [studentModelClass];
}

class ClassDataFailure extends ClassBlocState {
  final String failureMessage;
  const ClassDataFailure({
    required this.failureMessage,
  });
  @override
  List<Object> get props => [failureMessage];
}
