part of 'user_login_bloc.dart';

sealed class UserLoginState extends Equatable {
  const UserLoginState();

  @override
  List<Object> get props => [];
}

final class UserLoginInitial extends UserLoginState {}

final class SystemUserLoginProcess extends UserLoginState {}

final class SystemUserLoginSuccess extends UserLoginState {
  final List<MyUserModelClass> myUserModelClass;
  const SystemUserLoginSuccess({required this.myUserModelClass});
}

final class SystemUserInsertSuccess extends UserLoginState {
  final String successMessage;
  const SystemUserInsertSuccess({required this.successMessage});

  @override
  List<Object> get props => [successMessage];
}

final class SystemUserLoginFailure extends UserLoginState {
  final String message;
  const SystemUserLoginFailure({required this.message});

  @override
  List<Object> get props => [message];
}
