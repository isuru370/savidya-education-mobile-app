part of 'payment_monthly_report_bloc.dart';

@immutable
sealed class PaymentMonthlyReportEvent extends Equatable {
  const PaymentMonthlyReportEvent();

  @override
  List<Object> get props => [];
}

final class GetMonthlyPaymentEvent extends PaymentMonthlyReportEvent {
  final String paymentMonth;
  final int classHasCatId;

  const GetMonthlyPaymentEvent({
    required this.paymentMonth,
    required this.classHasCatId,
  });

  @override
  List<Object> get props => [paymentMonth, classHasCatId];
}
