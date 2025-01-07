part of 'student_half_payment_bloc.dart';

@immutable
sealed class StudentHalfPaymentEvent extends Equatable {
  const StudentHalfPaymentEvent();

  @override
  List<Object?> get props => [];
}

final class GetStudentHalfPaymentEvent extends StudentHalfPaymentEvent {
  final int studentId;
  final int classHasCatId;
  final String paymentMonth;

  const GetStudentHalfPaymentEvent({
    required this.studentId,
    required this.classHasCatId,
    required this.paymentMonth,
  });

  @override
  List<Object?> get props => [studentId, classHasCatId, paymentMonth];
}

final class UpdateStudentHalfPaymentEvent extends StudentHalfPaymentEvent {
  final StudentHalfPaymentModel studentHalfPaymentModel;
  final String msg;
  const UpdateStudentHalfPaymentEvent(
      {required this.studentHalfPaymentModel, required this.msg});

  @override
  List<Object?> get props => [studentHalfPaymentModel, msg];
}

final class StudentPaymentDeleteEvent extends StudentHalfPaymentEvent {
  final int paymentId;
  final String msg;
  const StudentPaymentDeleteEvent({required this.paymentId, required this.msg});

  @override
  List<Object?> get props => [paymentId,msg];
}

final class UpdateStudentPaymentEvent extends StudentHalfPaymentEvent {
  final StudentHalfPaymentModel studentHalfPaymentModel;
  final String msg;
  const UpdateStudentPaymentEvent(
      {required this.studentHalfPaymentModel, required this.msg});

  @override
  List<Object?> get props => [studentHalfPaymentModel, msg];
}
