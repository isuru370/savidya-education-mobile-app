part of 'qr_scanner_bloc.dart';

sealed class QrScannerState extends Equatable {
  const QrScannerState();

  @override
  List<Object> get props => [];
}

final class QrScannerInitial extends QrScannerState {}

final class AttendanceProcess extends QrScannerState {}

final class PaymentReadProcess extends QrScannerState {}

final class PaymentReadFailure extends QrScannerState {
  final String failureMessage;
  const PaymentReadFailure({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}

final class ReadAttendanceFailure extends QrScannerState {
  final String failureMessage;
  const ReadAttendanceFailure({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}

final class ReadAttendanceSuccess extends QrScannerState {
  final List<QrReadStudentModelClass> studentList;
  final List<QrReadClassCatModelClass> classAttList;
  final List<QrReadStudentPaymentModel> paymentList;
  const ReadAttendanceSuccess({
    required this.studentList,
    required this.classAttList,
    required this.paymentList,
  });

  @override
  List<Object> get props => [studentList, classAttList, paymentList];
}

final class PaymentReadSuccess extends QrScannerState {
  final List<LastPaymentModelClass> studentLastPaymentList;
  const PaymentReadSuccess({
    required this.studentLastPaymentList,
  });

  @override
  List<Object> get props => [studentLastPaymentList];
}

final class MarkAttendanceSuccess extends QrScannerState {
  final String successMessage;

  const MarkAttendanceSuccess({required this.successMessage});

  @override
  List<Object> get props => [successMessage];
}
