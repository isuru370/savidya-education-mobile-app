import 'package:equatable/equatable.dart';

sealed class StudentPaymentState extends Equatable {
  const StudentPaymentState();

  @override
  List<Object> get props => [];
}

final class StudentPaymentInitial extends StudentPaymentState {}

final class StudentPaymentProcess extends StudentPaymentState {}

final class StudentPaymentFailure extends StudentPaymentState {
  final String failureMessage;
  const StudentPaymentFailure({required this.failureMessage});
  @override
  List<Object> get props => [failureMessage];
}

final class StudentPaymentFailureSMS extends StudentPaymentState {
  final String failureSMSMessage;
  const StudentPaymentFailureSMS({required this.failureSMSMessage});
  @override
  List<Object> get props => [failureSMSMessage];
}

final class StudentPaymentSuccessSMS extends StudentPaymentState {
  final String failureSuccessSMSsMessage;
  const StudentPaymentSuccessSMS({required this.failureSuccessSMSsMessage});
  @override
  List<Object> get props => [failureSuccessSMSsMessage];
}

final class StudentPaymentSuccess extends StudentPaymentState {
  final String successMessage;
  const StudentPaymentSuccess({required this.successMessage});
  @override
  List<Object> get props => [successMessage];
}
