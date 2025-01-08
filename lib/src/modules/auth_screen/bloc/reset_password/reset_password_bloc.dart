import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/user/reset_password_service.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordInitial()) {
    on<EmailVerificationEvent>((event, emit) async {
      emit(PasswordResetProcess());
      try {
        await emailVerify(event.userName).then(
          (userVerify) {
            if (userVerify["success"]) {
              emit(const PasswordResetSuccess(
                  successMessage: "Mail sent successfully"));
            } else {
              emit(PasswordResetFailure(failureMessage: userVerify["message"]));
            }
          },
        );
      } catch (e) {
        // Log and emit failure state in case of exceptions
        log(e.toString());
        emit(const PasswordResetFailure(failureMessage: "User Not Found"));
      }
    });
    on<ChangePasswordEvent>((event, emit) async {
      emit(PasswordResetProcess());
      try {
        await passwordReset(event.userName, event.otp, event.password).then(
          (userVerify) {
            if (userVerify["success"]) {
              emit(const PasswordResetSuccess(
                  successMessage: "Password reset completed"));
            } else {
              emit(PasswordResetFailure(failureMessage: userVerify["message"]));
            }
          },
        );
      } catch (e) {
        // Log and emit failure state in case of exceptions
        log(e.toString());
        emit(const PasswordResetFailure(failureMessage: "User Not Found"));
      }
    });
  }
}
