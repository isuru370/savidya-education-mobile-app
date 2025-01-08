import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/payment_model_class/last_payment_model_class.dart';
import '../../../../models/qr_read/qr_read.dart';
import '../../../../services/qr_read/qr_read.dart';

part 'qr_scanner_event.dart';
part 'qr_scanner_state.dart';

class QrScannerBloc extends Bloc<QrScannerEvent, QrScannerState> {
  QrScannerBloc() : super(QrScannerInitial()) {
    on<ReadAttendanceEvent>((event, emit) async {
      emit(AttendanceProcess());
      try {
        await searchStudentAttendance(event.readAttendance)
            .then((readAttendance) {
          if (readAttendance['success']) {
            List<dynamic> readStu = readAttendance['student_data'];
            List<dynamic> readClass = readAttendance['category_data'];
            List<dynamic> readPayment = readAttendance['payment_result'];
            final List<QrReadStudentModelClass> qrReadStudentList = readStu
                .map((readStuJson) =>
                    QrReadStudentModelClass.fromJson(readStuJson))
                .toList();
            final List<QrReadClassCatModelClass> qrReadClassList = readClass
                .map((readClassJson) =>
                    QrReadClassCatModelClass.fromJson(readClassJson))
                .toList();
            final List<QrReadStudentPaymentModel> qrReadPayment = readPayment
                .map((readPaymentJson) =>
                    QrReadStudentPaymentModel.fromJson(readPaymentJson))
                .toList();

            emit(ReadAttendanceSuccess(
                studentList: qrReadStudentList,
                classAttList: qrReadClassList,
                paymentList: qrReadPayment));
          } else {
            emit(ReadAttendanceFailure(
                failureMessage: readAttendance['message']));
          }
        }).catchError((error) {
          emit(ReadAttendanceFailure(failureMessage: error));
        });
      } catch (e) {
        emit(ReadAttendanceFailure(failureMessage: e.toString()));
      }
    });
    on<MarkAttendanceEvent>((event, emit) async {
      emit(AttendanceProcess());
      try {
        await markStudentAttendance(event.readAttendance).then(
          (markAttendance) {
            if (markAttendance['success']) {
              emit(const MarkAttendanceSuccess(
                successMessage: "Attendance marked successfully",
              ));
            } else {
              emit(ReadAttendanceFailure(
                failureMessage: markAttendance["message"],
              ));
            }
          },
        );
      } catch (e) {
        emit(const ReadAttendanceFailure(
          failureMessage: 'Failed to insert attendance data.',
        ));
      }
    });
    on<StudentPaymentReadEvent>((event, emit) async {
      emit(PaymentReadProcess());
      try {
        await searchStudentPayment(event.studentCustomId).then(
          (readPayment) {
            if (readPayment['success']) {
              List<dynamic> lastPayment = readPayment['student_payment_data'];
              final List<LastPaymentModelClass> qrReadStudentPaymentList =
                  lastPayment
                      .map((readLastPaymentJson) =>
                          LastPaymentModelClass.fromJson(
                              readLastPaymentJson))
                      .toList();

              emit(PaymentReadSuccess(
                  studentLastPaymentList: qrReadStudentPaymentList));
            } else {
              emit(const PaymentReadFailure(
                  failureMessage: "No data found for the given student."));
            }
          },
        );
      } catch (e) {
        emit(PaymentReadFailure(failureMessage: e.toString()));
      }
    });
  }
}
