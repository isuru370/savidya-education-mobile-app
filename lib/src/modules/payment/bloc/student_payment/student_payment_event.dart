part of 'student_payment_bloc.dart';

sealed class StudentPaymentEvent extends Equatable {
  const StudentPaymentEvent();

  @override
  List<Object> get props => [];
}

final class InsertStudentPaymentEvent extends StudentPaymentEvent {
  final PaymentModelClass paymentModelClass;
  final String msg;
  final String number;
  const InsertStudentPaymentEvent({
    required this.paymentModelClass,
    required this.msg,
    required this.number,
  });

  @override
  List<Object> get props => [
        paymentModelClass,
        msg,
        number,
      ];
}
