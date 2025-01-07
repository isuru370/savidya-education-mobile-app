part of 'get_admission_bloc.dart';

sealed class GetAdmissionEvent extends Equatable {
  const GetAdmissionEvent();

  @override
  List<Object> get props => [];
}

final class GetAdmission extends GetAdmissionEvent {}
