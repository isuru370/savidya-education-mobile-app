part of 'teacher_bloc.dart';

sealed class TeacherState extends Equatable {
  const TeacherState();

  @override
  List<Object> get props => [];
}

final class TeacherInitial extends TeacherState {}

final class InsertDataProcess extends TeacherState {}

final class InsertDataSuccess extends TeacherState {
  final String successMessage;
  const InsertDataSuccess({required this.successMessage});

  @override
  List<Object> get props => [successMessage];
}

final class GetTeacherSuccess extends TeacherState {
  final List<TeacherModelClass> getActiveTeacherList;
  const GetTeacherSuccess({required this.getActiveTeacherList});

  @override
  List<Object> get props => [getActiveTeacherList];
}

final class GetTeacherFailure extends TeacherState {
  final String message;
  const GetTeacherFailure({required this.message});

  @override
  List<Object> get props => [message];
}
