import 'dart:developer';

import 'package:aloka_mobile_app/src/models/reports/reports_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/payment_model_class/payment_monthly_report_model.dart';
import '../../../../services/reports/reports_services.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  ReportsBloc() : super(ReportsInitial()) {
    on<DallyReports>((event, emit) async {
      emit(ReportsProcess());
      try {
        await paymentDallyReport(event.selectDate).then(
          (dallyReports) {
            if (dallyReports['success']) {
              final List<dynamic> dallyPayment =
                  dallyReports['daily_payment_data'];
              final List<ReportsModel> dallyPaymentList = dallyPayment
                  .map((dallyPaymentJson) =>
                      ReportsModel.fromJson(dallyPaymentJson))
                  .toList();
              emit(ReportsDally(reportsModel: dallyPaymentList));
            } else {
              emit(ReportsFailure(failureMSG: dallyReports['message']));
            }
          },
        );
      } catch (e) {
        log(e.toString());
        emit(const ReportsFailure(failureMSG: "not found"));
      }
    });
    on<MonthlyReports>((event, emit) async {
      emit(ReportsProcess());
      try {
        await paymentMonthlyReport(event.selectMonth).then(
          (monthlyReports) {
            if (monthlyReports['success']) {
              final List<dynamic> monthlyPayment =
                  monthlyReports['payment_monthly_data'];
              final List<ReportsModel> monthlyPaymentList = monthlyPayment
                  .map((dallyPaymentJson) =>
                      ReportsModel.fromJson(dallyPaymentJson))
                  .toList();
              emit(ReportsMonthly(reportsModel: monthlyPaymentList));
            } else {
              emit(ReportsFailure(failureMSG: monthlyReports['message']));
            }
          },
        );
      } catch (e) {
        log(e.toString());
        emit(const ReportsFailure(failureMSG: "not found"));
      }
    });
    on<TeacherPaymentMonthlyReports>((event, emit) async {
      emit(ReportsProcess());
      try {
        await teacherPaymentMonthlyReport(event.selectMonth, event.teacherId)
            .then(
          (teacherReports) {
            if (teacherReports['success']) {
              final List<dynamic> teacherPayment =
                  teacherReports['teacher_payment_monthly_data'];
              final List<ReportsModel> teacherPaymentList = teacherPayment
                  .map((dallyPaymentJson) =>
                      ReportsModel.fromJson(dallyPaymentJson))
                  .toList();
              emit(ReportsTeacherPayment(reportsModel: teacherPaymentList));
            } else {
              emit(ReportsFailure(failureMSG: teacherReports['message']));
            }
          },
        );
      } catch (e) {
        log(e.toString());
        emit(const ReportsFailure(failureMSG: "not found"));
      }
    });
    on<ClassPaymentMonthlyReports>((event, emit) async {
      emit(ReportsProcess());
      try {
        await classPaidNotPaidReport(event.selectMonth,event.classHasCatId).then(
          (paidNotPaidReports) {
            if (paidNotPaidReports['success']) {
              final List<dynamic> paidNotPaidPayment =
                  paidNotPaidReports['paid_not_paid_data'];
              final List<PaymentMonthlyReportModel> paidNotPaidPaymentList =
                  paidNotPaidPayment
                      .map((dallyPaymentJson) =>
                      PaymentMonthlyReportModel.fromJson(dallyPaymentJson))
                      .toList();
              emit(ReportsClassPaidNotPaid(
                  reportsModel: paidNotPaidPaymentList));
            } else {
              emit(ReportsFailure(failureMSG: paidNotPaidReports['message']));
            }
          },
        );
      } catch (e) {
        log(e.toString());
        emit(const ReportsFailure(failureMSG: "not found"));
      }
    });
  }
}
