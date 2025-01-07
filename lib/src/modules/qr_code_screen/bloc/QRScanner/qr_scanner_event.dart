part of 'qr_scanner_bloc.dart';

sealed class QrScannerEvent extends Equatable {
  const QrScannerEvent();

  @override
  List<Object> get props => [];
}

class ReadAttendanceEvent extends QrScannerEvent {
  final QrReadStudentModelClass readAttendance;
  const ReadAttendanceEvent({required this.readAttendance});

  @override
  List<Object> get props => [readAttendance];
}

class MarkAttendanceEvent extends QrScannerEvent {
  final QrReadStudentModelClass readAttendance;
  const MarkAttendanceEvent({required this.readAttendance});

  @override
  List<Object> get props => [readAttendance];
}

class StudentPaymentReadEvent extends QrScannerEvent {
  final String studentCustomId;
  const StudentPaymentReadEvent({required this.studentCustomId});
}
