part of 'payment_monthly_report_bloc.dart';

@immutable
sealed class PaymentMonthlyReportState extends Equatable {
  const PaymentMonthlyReportState();
  @override
  List<Object?> get props => [];
}

final class PaymentMonthlyReportInitial extends PaymentMonthlyReportState {}

final class MonthlyPaymentProcess extends PaymentMonthlyReportState {}

final class MonthlyPaymentFailure extends PaymentMonthlyReportState {
  final String failureMessage;
  const MonthlyPaymentFailure({required this.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}

final class MonthlyPaymentSuccess extends PaymentMonthlyReportState {
  final List<PaymentMonthlyReportModel> paymentMonthlyReport;
  const MonthlyPaymentSuccess({required this.paymentMonthlyReport});

  @override
  List<Object?> get props => [paymentMonthlyReport];
}
