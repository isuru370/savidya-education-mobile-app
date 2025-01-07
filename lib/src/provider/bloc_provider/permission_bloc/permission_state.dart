part of 'permission_bloc.dart';

sealed class PermissionState extends Equatable {
  const PermissionState();

  @override
  List<Object> get props => [];
}

final class PermissionInitial extends PermissionState {}

final class PermissionProcess extends PermissionState {}

final class PermissionSuccess extends PermissionState {
  final bool permissionMessage;
  const PermissionSuccess({required this.permissionMessage});

  @override
  List<Object> get props => [permissionMessage];
}
