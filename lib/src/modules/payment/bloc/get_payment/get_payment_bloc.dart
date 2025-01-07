import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/payment_model_class/payment_model_class.dart';
import '../../../../services/payment/payment_service.dart';

part 'get_payment_event.dart';
part 'get_payment_state.dart';

class GetPaymentBloc extends Bloc<GetPaymentEvent, GetPaymentState> {
  GetPaymentBloc() : super(GetPaymentInitial()) {
    on<GetUniqueStudentPaymentEvent>((event, emit) async {
      emit(GetPaymentProcess());
      try {
        await getUniqueStudentPayment(
          event.studentId,
          event.classCategoryHasStudentClassId,
        ).then(
          (getUniqueStudentPayment) {
            if (getUniqueStudentPayment['success']) {
              List<dynamic> paymentList =
                  getUniqueStudentPayment['unique_payment_data'];
              final List<PaymentModelClass> paymentUniqueList = paymentList
                  .map((uniqPaymentJson) =>
                      PaymentModelClass.uniquePaymentJson(uniqPaymentJson))
                  .toList();
              emit(GetPaymentSuccess(paymentModelClassList: paymentUniqueList));
            } else {
              emit(GetPaymentFailure(
                  failureMessage: getUniqueStudentPayment['message']));
            }
          },
        );
      } catch (e) {
        emit(const GetPaymentFailure(failureMessage: "Failure Message"));
        log(e.toString());
      }
    });
  }
}
