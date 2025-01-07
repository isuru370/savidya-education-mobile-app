part of 'permission_bloc.dart';

sealed class PermissionEvent extends Equatable {
  const PermissionEvent();

  @override
  List<Object> get props => [];
}

final class GetUserPermissionEvent extends PermissionEvent {
  final PermissionModel permissionModel;
  const GetUserPermissionEvent({required this.permissionModel});

   @override
  List<Object> get props => [permissionModel];
}
