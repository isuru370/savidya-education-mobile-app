part of 'tute_bloc.dart';

@immutable
sealed class TuteState extends Equatable {
  const TuteState();
  @override
  List<Object?> get props => [];
}

final class TuteInitial extends TuteState {}

final class TuteProcessState extends TuteState {}

final class TuteFailureState extends TuteState {
  final String failureMessage;
  const TuteFailureState({required this.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}


final class CheckTuteSuccessState extends TuteState {
  final int chackTute;
  const CheckTuteSuccessState({required this.chackTute});

  @override
  List<Object?> get props => [chackTute];
}

final class InsertTuteSuccessState extends TuteState {
  final String successMessage;
  const InsertTuteSuccessState({required this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

final class UpdateTuteSuccessState extends TuteState {
  final String updateMessage;
  const UpdateTuteSuccessState({required this.updateMessage});

  @override
  List<Object?> get props => [updateMessage];
}

final class GetStudentTuteSuccessState extends TuteState {
  final List<TuteModelClass> tuteModelClass;
  const GetStudentTuteSuccessState({required this.tuteModelClass});

  @override
  List<Object?> get props => [tuteModelClass];
}