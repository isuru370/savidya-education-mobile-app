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
  final String message;
  final String studentMobileNumber;
  const MarkAttendanceEvent({
    required this.readAttendance,
    required this.message,
    required this.studentMobileNumber,
  });

  @override
  List<Object> get props => [readAttendance, message, studentMobileNumber];
}

class StudentPaymentReadEvent extends QrScannerEvent {
  final String studentCustomId;
  const StudentPaymentReadEvent({required this.studentCustomId});
}
