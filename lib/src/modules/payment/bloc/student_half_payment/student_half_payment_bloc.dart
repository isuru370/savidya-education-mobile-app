import 'dart:developer';

import 'package:aloka_mobile_app/src/models/payment_model_class/student_half_payment_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/payment/payment_service.dart';

part 'student_half_payment_event.dart';
part 'student_half_payment_state.dart';

class StudentHalfPaymentBloc
    extends Bloc<StudentHalfPaymentEvent, StudentHalfPaymentState> {
  StudentHalfPaymentBloc() : super(StudentHalfPaymentInitial()) {
    on<GetStudentHalfPaymentEvent>((event, emit) async {
      emit(StudentHalfPaymentProcess());
      try {
        await studentHalfPayment(
                event.studentId, event.classHasCatId, event.paymentMonth)
            .then(
          (studentHalfPayment) {
            if (studentHalfPayment['success']) {
              final List<dynamic> studentHalfPaymentData =
                  studentHalfPayment['student_half_payment_data'];
              final List<StudentHalfPaymentModel> studentHalfPaymentList =
                  studentHalfPaymentData
                      .map((halfPaymentJson) =>
                          StudentHalfPaymentModel.fromJson(halfPaymentJson))
                      .toList();
              emit(StudentHalfPaymentSuccess(
                  studentHalfPaymentModel: studentHalfPaymentList));
            } else {
              emit(StudentHalfPaymentFailure(
                  failureMessage: studentHalfPayment['message']));
            }
          },
        );
      } catch (e) {
        log(e.toString());
        emit(const StudentHalfPaymentFailure(failureMessage: "data not found"));
      }
    });
    on<UpdateStudentHalfPaymentEvent>((event, emit) async {
      emit(StudentHalfPaymentProcess());
      try {
        await studentPaymentUpdate(event.studentHalfPaymentModel).then(
          (paymentUpdate) async {
            if (paymentUpdate['success']) {
              // If the payment deletion is successful, send the notification message
              await sendPaymentMessage(event.msg, "+94779947289").then(
                (sendMSG) {
                  if (sendMSG['success']) {
                    // Emit success state with a success message
                    emit(StudentHalfPaymentUpdateSuccess(
                      halfPaymentUpdateMsg: paymentUpdate['message'],
                    ));
                  } else {
                    // Emit failure state if the message sending fails
                    emit(const StudentHalfPaymentFailure(
                      failureMessage: "Failed to send notification message.",
                    ));
                  }
                  emit(StudentHalfPaymentUpdateSuccess(
                    halfPaymentUpdateMsg: paymentUpdate['message'],
                  ));
                },
              );
            } else {
              // Emit failure state if payment deletion fails
              emit(StudentHalfPaymentFailure(
                failureMessage: paymentUpdate['message'],
              ));
            }
          },
        );
      } catch (e) {
        log(e.toString());
        emit(const StudentHalfPaymentFailure(failureMessage: "not found data"));
      }
    });

    on<UpdateStudentPaymentEvent>((event, emit) async {
      emit(StudentHalfPaymentProcess());
      try {
        await studentPaymentUpdate(event.studentHalfPaymentModel).then(
          (paymentUpdate) async {
            if (paymentUpdate['success']) {
              // If the payment deletion is successful, send the notification message
              await sendPaymentMessage(event.msg, "+94779947289").then(
                (sendMSG) {
                  if (sendMSG['success']) {
                    // Emit success state with a success message
                    emit(StudentPaymentUpdateSuccess(
                      paymentUpdateMsg: paymentUpdate['message'],
                    ));
                  } else {
                    // Emit failure state if the message sending fails
                    emit(const StudentHalfPaymentFailure(
                      failureMessage: "Failed to send notification message.",
                    ));
                  }
                  emit(StudentPaymentUpdateSuccess(
                    paymentUpdateMsg: paymentUpdate['message'],
                  ));
                },
              );
            } else {
              // Emit failure state if payment deletion fails
              emit(StudentHalfPaymentFailure(
                failureMessage: paymentUpdate['message'],
              ));
            }
          },
        );
      } catch (e) {
        log(e.toString());
        emit(const StudentHalfPaymentFailure(failureMessage: "not found data"));
      }
    });
    on<StudentPaymentDeleteEvent>((event, emit) async {
      emit(StudentHalfPaymentProcess()); // Emitting loading state

      try {
        // Calling the function to delete the payment
        await studentPaymentDelete(event.paymentId).then(
          (paymentDelete) async {
            if (paymentDelete['success']) {
              // If the payment deletion is successful, send the notification message
              await sendPaymentMessage(event.msg, "+94779947289").then(
                (sendMSG) {
                  if (sendMSG['success']) {
                    // Emit success state with a success message
                    emit(StudentHalfPaymentDeleteSuccess(
                      halfPaymentDeleteMsg: paymentDelete['message'],
                    ));
                  } else {
                    // Emit failure state if the message sending fails
                    emit(const StudentHalfPaymentFailure(
                      failureMessage: "Failed to send notification message.",
                    ));
                  }
                  emit(StudentHalfPaymentDeleteSuccess(
                    halfPaymentDeleteMsg: paymentDelete['message'],
                  ));
                },
              );
            } else {
              // Emit failure state if payment deletion fails
              emit(StudentHalfPaymentFailure(
                failureMessage: paymentDelete['message'],
              ));
            }
          },
        );
      } catch (e) {
        log(e.toString()); // Log the error
        // Emit failure state in case of exceptions
        emit(const StudentHalfPaymentFailure(
            failureMessage: "Unexpected error occurred."));
      }
    });
  }
}
