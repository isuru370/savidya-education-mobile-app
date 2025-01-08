import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/payment_model_class/payment_model_class.dart';
import '../../../../services/payment/payment_service.dart';
import 'student_payment_state.dart';

part 'student_payment_event.dart';

class StudentPaymentBloc
    extends Bloc<StudentPaymentEvent, StudentPaymentState> {
  StudentPaymentBloc() : super(StudentPaymentInitial()) {
    on<InsertStudentPaymentEvent>((event, emit) async {
      emit(StudentPaymentProcess());

      try {
        // Step 1: Insert the payment
        final studentPayment =
            await studentPaymentInsert(event.paymentModelClass);

        if (studentPayment['success']) {
          // Emit success state
          emit(const StudentPaymentSuccess(
              successMessage: 'Payment successfully inserted.'));

          // Step 2: Send the SMS if payment is successful
          final sendMessage = await sendPaymentMessage(event.msg, event.number);

          if (sendMessage['success']) {
            emit(const StudentPaymentSuccessSMS(
                failureSuccessSMSsMessage:
                    'Payment inserted and message sent.'));
          } else {
            emit(const StudentPaymentFailureSMS(
                failureSMSMessage: "Failed to send payment message"));
          }
        } else {
          emit(
              StudentPaymentFailure(failureMessage: studentPayment['message']));
        }
      } catch (e) {
        emit(const StudentPaymentFailure(failureMessage: "Payment not saved"));
        log(e.toString());
      }
    });
  }
}
