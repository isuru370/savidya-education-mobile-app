part of 'get_payment_bloc.dart';

sealed class GetPaymentEvent extends Equatable {
  const GetPaymentEvent();

  @override
  List<Object> get props => [];
}

final class GetUniqueStudentPaymentEvent extends GetPaymentEvent {
  final int studentId;
  final int classCategoryHasStudentClassId;
  const GetUniqueStudentPaymentEvent({
    required this.studentId,
    required this.classCategoryHasStudentClassId,
  });

  @override
  List<Object> get props => [studentId, classCategoryHasStudentClassId];
}
