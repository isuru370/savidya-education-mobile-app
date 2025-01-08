import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/permission_model/permission_model.dart';
import '../../../services/permissions_service/permissions_service.dart';

part 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc() : super(PermissionInitial()) {
    on<GetUserPermissionEvent>((event, emit) async {
      emit(PermissionProcess());
      try {
        await permissionResult(event.permissionModel).then(
          (result) {
            emit(PermissionSuccess(permissionMessage: result['success']));
          },
        );
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
