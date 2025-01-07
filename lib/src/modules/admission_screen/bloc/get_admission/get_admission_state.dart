part of 'get_admission_bloc.dart';

sealed class GetAdmissionState extends Equatable {
  const GetAdmissionState();

  @override
  List<Object> get props => [];
}

final class GetAdmissionInitial extends GetAdmissionState {}

final class GetAdmissionProcess extends GetAdmissionState {}

final class GetAdmissionFailure extends GetAdmissionState {}

final class GetAdmissionSuccess extends GetAdmissionState {
  final List<AdmissionModelClass> admissionModel;
  const GetAdmissionSuccess({required this.admissionModel});

  @override
  List<Object> get props => [admissionModel];
}
