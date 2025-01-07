part of 'admission_payment_bloc.dart';

sealed class AdmissionPaymentState extends Equatable {
  const AdmissionPaymentState();

  @override
  List<Object> get props => [];
}

final class AdmissionPaymentInitial extends AdmissionPaymentState {}

final class AdmissionPaymentProcess extends AdmissionPaymentState {}

final class AdmissionPaymentFailure extends AdmissionPaymentState {
  final String failureMessage;
  const AdmissionPaymentFailure({required this.failureMessage});
  @override
  List<Object> get props => [failureMessage];
}

final class AdmissionPaymentSuccess extends AdmissionPaymentState {
  final String successMessage;
  const AdmissionPaymentSuccess({required this.successMessage});
  @override
  List<Object> get props => [successMessage];
}

final class TodayAdmissionPaymentSuccess extends AdmissionPaymentState {
  final List<AdmissionPaymentModelClass> todayAdmissionPayment;
  const TodayAdmissionPaymentSuccess({required this.todayAdmissionPayment});

  @override
  List<Object> get props => [todayAdmissionPayment];
}
