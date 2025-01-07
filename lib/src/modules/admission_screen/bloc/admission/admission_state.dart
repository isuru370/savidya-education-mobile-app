part of 'admission_bloc.dart';

sealed class AdmissionState extends Equatable {
  const AdmissionState();

  @override
  List<Object> get props => [];
}

final class AdmissionInitial extends AdmissionState {}

final class AddAdmissionProcess extends AdmissionState {}

final class AddAdmissionFailure extends AdmissionState {
  final String failureMessage;
  const AddAdmissionFailure({required this.failureMessage});
  @override
  List<Object> get props => [failureMessage];
}

final class AddAdmissionSuccess extends AdmissionState {
  final String successMessage;
  const AddAdmissionSuccess({required this.successMessage});
  @override
  List<Object> get props => [successMessage];
}
