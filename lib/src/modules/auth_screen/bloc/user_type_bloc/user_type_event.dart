part of 'user_type_bloc.dart';

sealed class UserTypeEvent extends Equatable {
  const UserTypeEvent();

  @override
  List<Object> get props => [];
}

final class GetUserTypeEvent extends UserTypeEvent{}
