part of 'qr_scanner_cubit.dart';

sealed class QrScannerState extends Equatable {
  const QrScannerState();

  @override
  List<Object> get props => [];
}

final class QrScannerInitial extends QrScannerState {}

final class QrScannerProcess extends QrScannerState {}

final class QrScannerFailure extends QrScannerState {
  final String failureMSG;
  const QrScannerFailure({required this.failureMSG});

  @override
  List<Object> get props => [failureMSG];
}

final class QrScannerSuccess extends QrScannerState {
  final String qrScannerResult;
  const QrScannerSuccess({required this.qrScannerResult});

  @override
  List<Object> get props => [qrScannerResult];
}
