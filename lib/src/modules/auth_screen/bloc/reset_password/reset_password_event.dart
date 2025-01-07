part of 'reset_password_bloc.dart';

sealed class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

final class EmailVerificationEvent extends ResetPasswordEvent {
  final String userName;
  const EmailVerificationEvent({required this.userName});

  @override
  List<Object> get props => [userName];
}

final class ChangePasswordEvent extends ResetPasswordEvent {
  final int otp;
  final String password;
  final String userName;
  const ChangePasswordEvent({
    required this.otp,
    required this.password,
    required this.userName,
  });

  @override
  List<Object> get props => [otp, password, userName];
}
