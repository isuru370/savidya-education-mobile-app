part of 'user_login_bloc.dart';

sealed class UserLoginEvent extends Equatable {
  const UserLoginEvent();

  @override
  List<Object> get props => [];
}

class SystemUserLoginEvent extends UserLoginEvent {
  final MyUserModelClass myUser;

  const SystemUserLoginEvent({required this.myUser});
  @override
  List<Object> get props => [myUser];
}

class InsertSystemUserEvent extends UserLoginEvent {
  final MyUserModelClass myUser;

  const InsertSystemUserEvent({required this.myUser});

  @override
  List<Object> get props => [myUser];
}
