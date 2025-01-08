import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/admission/admission_payment_model.dart';
import '../../../../services/admission_service/admission_service.dart';

part 'admission_payment_event.dart';
part 'admission_payment_state.dart';

class AdmissionPaymentBloc
    extends Bloc<AdmissionPaymentEvent, AdmissionPaymentState> {
  AdmissionPaymentBloc() : super(AdmissionPaymentInitial()) {
    on<AdmissionPayment>((event, emit) async {
      emit(AdmissionPaymentProcess());
      try {
        await updateAdmissionData(event.admissionPaymentModelClass).then(
          (admissionPay) {
            if (admissionPay['success']) {
              emit(AdmissionPaymentSuccess(
                  successMessage: admissionPay['message']));
            } else {
              emit(AdmissionPaymentFailure(
                  failureMessage: admissionPay['message']));
            }
          },
        );
      } catch (e) {
        emit(const AdmissionPaymentFailure(failureMessage: "failureMessage"));
        log(e.toString());
      }
    });
    on<TodayAdmissionPaymentEvent>((event, emit) async {
      emit(AdmissionPaymentProcess());
      try {
        await todayGetAdmissionPayment().then(
          (admissionPayment) {
            if (admissionPayment['success']) {
              final List<dynamic> admissionPayData =
                  admissionPayment['today_admission_payment_data'];
              final List<AdmissionPaymentModelClass> admissionPaymentList =
                  admissionPayData
                      .map((admissionPayJson) =>
                          AdmissionPaymentModelClass.admissionPayFromJson(
                              admissionPayJson))
                      .toList();

              emit(TodayAdmissionPaymentSuccess(
                  todayAdmissionPayment: admissionPaymentList));
            } else {
              emit(AdmissionPaymentFailure(
                  failureMessage: admissionPayment['message']));
            }
          },
        );
      } catch (e) {
        log(e.toString());
        emit(const AdmissionPaymentFailure(
            failureMessage: "Admission Payment Error"));
      }
    });
  }
}
