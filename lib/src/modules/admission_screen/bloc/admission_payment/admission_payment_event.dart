part of 'admission_payment_bloc.dart';

sealed class AdmissionPaymentEvent extends Equatable {
  const AdmissionPaymentEvent();

  @override
  List<Object> get props => [];
}

final class AdmissionPayment extends AdmissionPaymentEvent {
  final AdmissionPaymentModelClass admissionPaymentModelClass;
  const AdmissionPayment({required this.admissionPaymentModelClass});

   @override
  List<Object> get props => [admissionPaymentModelClass];
}


final class TodayAdmissionPaymentEvent extends AdmissionPaymentEvent{}

