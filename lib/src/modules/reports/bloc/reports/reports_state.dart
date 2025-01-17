part of 'reports_bloc.dart';

sealed class ReportsState extends Equatable {
  const ReportsState();

  @override
  List<Object> get props => [];
}

final class ReportsInitial extends ReportsState {}

final class ReportsProcess extends ReportsState {}

final class ReportsFailure extends ReportsState {
  final String failureMSG;

  const ReportsFailure({required this.failureMSG});

  @override
  List<Object> get props => [failureMSG];
}

final class ReportsDally extends ReportsState {
  final List<ReportsModel> reportsModel;

  const ReportsDally({required this.reportsModel});

  @override
  List<Object> get props => [reportsModel];
}

final class ReportsMonthly extends ReportsState {
  final List<ReportsModel> reportsModel;

  const ReportsMonthly({required this.reportsModel});

  @override
  List<Object> get props => [reportsModel];
}

final class ReportsTeacherPayment extends ReportsState {
  final List<ReportsModel> reportsModel;

  const ReportsTeacherPayment({required this.reportsModel});

  @override
  List<Object> get props => [reportsModel];
}

final class ReportsClassPaidNotPaid extends ReportsState {
  final List<PaymentMonthlyReportModel> reportsModel;

  const ReportsClassPaidNotPaid({required this.reportsModel});

  @override
  List<Object> get props => [reportsModel];
}
