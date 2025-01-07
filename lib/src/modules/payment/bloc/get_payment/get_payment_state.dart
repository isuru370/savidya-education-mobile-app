part of 'get_payment_bloc.dart';

sealed class GetPaymentState extends Equatable {
  const GetPaymentState();

  @override
  List<Object> get props => [];
}

final class GetPaymentInitial extends GetPaymentState {}

final class GetPaymentProcess extends GetPaymentState {}

final class GetPaymentFailure extends GetPaymentState {
  final String failureMessage;
  const GetPaymentFailure({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}

final class GetPaymentSuccess extends GetPaymentState {
  final List<PaymentModelClass> paymentModelClassList;
  const GetPaymentSuccess({required this.paymentModelClassList});

  @override
  List<Object> get props => [paymentModelClassList];
}
