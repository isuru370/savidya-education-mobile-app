part of 'user_type_bloc.dart';

sealed class UserTypeState extends Equatable {
  const UserTypeState();

  @override
  List<Object> get props => [];
}

final class UserTypeInitial extends UserTypeState {}

final class GetUserTypeState extends UserTypeState {
  final List<UserTypeModelClass> userTypeList;
  const GetUserTypeState({required this.userTypeList});

  @override
  List<Object> get props => [userTypeList];
}

final class GetUserTypeFailureState extends UserTypeState {
  final String failureMessage;
  const GetUserTypeFailureState({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}
