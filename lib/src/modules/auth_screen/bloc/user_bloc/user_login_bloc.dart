import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/user/user_model.dart';
import '../../../../services/user/login_user.dart';

part 'user_login_event.dart';
part 'user_login_state.dart';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  UserLoginBloc() : super(UserLoginInitial()) {
    on<SystemUserLoginEvent>((event, emit) async {
      try {
        emit(SystemUserLoginProcess());
        await loginUser(event.myUser).then(
          (loginUserData) {
            if (loginUserData['success']) {
              final List<dynamic> getSystemUser = loginUserData['system_users'];
              final List<MyUserModelClass> systemUserList = getSystemUser
                  .map((systemUserJson) =>
                      MyUserModelClass.fromJson(systemUserJson))
                  .toList();
              emit(SystemUserLoginSuccess(myUserModelClass: systemUserList));
            } else {
              emit(SystemUserLoginFailure(message: loginUserData['message']));
            }
          },
        );
      } catch (e) {
        emit(const SystemUserLoginFailure(
            message: "Exception. Incorrect username or password."));
        log(e.toString());
      }
    });
    on<InsertSystemUserEvent>((event, emit) async {
      try {
        emit(SystemUserLoginProcess());
        await insertUserData(event.myUser).then(
          (insertSystemUser) {
            if (insertSystemUser['success']) {
              emit(SystemUserInsertSuccess(
                  successMessage: insertSystemUser['message']));
            } else {
              emit(
                  SystemUserLoginFailure(message: insertSystemUser['message']));
            }
          },
        );
      } catch (e) {
        emit(const SystemUserLoginFailure(
            message: "Exception. User creation failed"));
        log(e.toString());
      }
    });
  }
}
