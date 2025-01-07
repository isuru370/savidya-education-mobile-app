part of 'student_half_payment_bloc.dart';

@immutable
sealed class StudentHalfPaymentState extends Equatable {
  const StudentHalfPaymentState();

  @override
  List<Object?> get props => [];
}

final class StudentHalfPaymentInitial extends StudentHalfPaymentState {}

final class StudentHalfPaymentProcess extends StudentHalfPaymentState {}

final class StudentHalfPaymentFailure extends StudentHalfPaymentState {
  final String failureMessage;
  const StudentHalfPaymentFailure({required this.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}

final class StudentHalfPaymentSuccess extends StudentHalfPaymentState {
  final List<StudentHalfPaymentModel> studentHalfPaymentModel;
  const StudentHalfPaymentSuccess({required this.studentHalfPaymentModel});

  @override
  List<Object?> get props => [studentHalfPaymentModel];
}

final class StudentHalfPaymentUpdateSuccess extends StudentHalfPaymentState {
  final String halfPaymentUpdateMsg;
  const StudentHalfPaymentUpdateSuccess({required this.halfPaymentUpdateMsg});

  @override
  List<Object?> get props => [halfPaymentUpdateMsg];
}

final class StudentHalfPaymentDeleteSuccess extends StudentHalfPaymentState {
  final String halfPaymentDeleteMsg;
  const StudentHalfPaymentDeleteSuccess({required this.halfPaymentDeleteMsg});

  @override
  List<Object?> get props => [halfPaymentDeleteMsg];
}

final class StudentPaymentUpdateSuccess extends StudentHalfPaymentState {
  final String paymentUpdateMsg;
  const StudentPaymentUpdateSuccess({required this.paymentUpdateMsg});

  @override
  List<Object?> get props => [paymentUpdateMsg];
}
