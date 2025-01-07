import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/user/user_type_model.dart';
import '../../../../services/user/user_type_service.dart';

part 'user_type_event.dart';
part 'user_type_state.dart';

class UserTypeBloc extends Bloc<UserTypeEvent, UserTypeState> {
  UserTypeBloc() : super(UserTypeInitial()) {
    on<GetUserTypeEvent>((event, emit) async {
      try {
        await getUserType().then(
          (getUserType) {
            if (getUserType['success']) {
              List<dynamic> userType = getUserType["user_type"];
              final List<UserTypeModelClass> userTypeList = userType
                  .map(
                      (teacherJson) => UserTypeModelClass.fromJson(teacherJson))
                  .toList();
              emit(GetUserTypeState(userTypeList: userTypeList));
            } else {
              emit(GetUserTypeFailureState(
                  failureMessage: getUserType['message']));
            }
          },
        );
      } catch (e) {
        emit(const GetUserTypeFailureState(failureMessage: "not found"));
        log(e.toString());
      }
    });
  }
}
