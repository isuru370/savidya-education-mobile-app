import 'dart:developer';

import 'package:aloka_mobile_app/src/models/payment_model_class/payment_monthly_report_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/payment/payment_service.dart';

part 'payment_monthly_report_event.dart';
part 'payment_monthly_report_state.dart';

class PaymentMonthlyReportBloc
    extends Bloc<PaymentMonthlyReportEvent, PaymentMonthlyReportState> {
  PaymentMonthlyReportBloc() : super(PaymentMonthlyReportInitial()) {
    on<GetMonthlyPaymentEvent>((event, emit) async {
      emit(MonthlyPaymentProcess());
      try {
        await monthlyPaymentReport(event.paymentMonth, event.classHasCatId)
            .then(
          (report) {
            if (report['success']) {
              final List<dynamic> monthlyPaymentData =
                  report['monthly_payment_data'];
              final List<PaymentMonthlyReportModel> paymentMonthlyReportList =
                  monthlyPaymentData
                      .map((monthlyPaymentJson) =>
                          PaymentMonthlyReportModel.fromJson(
                              monthlyPaymentJson))
                      .toList();
              emit(MonthlyPaymentSuccess(
                  paymentMonthlyReport: paymentMonthlyReportList));
            } else {
              emit(MonthlyPaymentFailure(failureMessage: report['message']));
            }
          },
        );
      } catch (e) {
        log(e.toString());
        emit(const MonthlyPaymentFailure(failureMessage: "Data not found"));
      }
    });
  }
}
