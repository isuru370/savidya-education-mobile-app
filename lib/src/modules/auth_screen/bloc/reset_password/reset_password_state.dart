part of 'reset_password_bloc.dart';

sealed class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

final class ResetPasswordInitial extends ResetPasswordState {}

final class PasswordResetProcess extends ResetPasswordState {}

final class PasswordResetFailure extends ResetPasswordState {
  final String failureMessage;
  const PasswordResetFailure({required this.failureMessage});
}

final class PasswordResetSuccess extends ResetPasswordState {
  final String successMessage;
  const PasswordResetSuccess({required this.successMessage});
}
