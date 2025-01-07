part of 'admission_bloc.dart';

sealed class AdmissionEvent extends Equatable {
  const AdmissionEvent();

  @override
  List<Object> get props => [];
}

final class AddAdmissionEvent extends AdmissionEvent {
  final AdmissionModelClass admissionModelClass;
  const AddAdmissionEvent({required this.admissionModelClass});

  @override
  List<Object> get props => [admissionModelClass];
}
