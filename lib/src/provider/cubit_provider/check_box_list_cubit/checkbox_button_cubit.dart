import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkbox_button_state.dart';

class CheckboxButtonCubit extends Cubit<CheckboxButtonState> {
  CheckboxButtonCubit()
      : super(const CheckboxButtonInitial(
          isStudentActiveStatus: false,
          isStudentFreeCard: false,
          isTeacherActiveStatus: false,
          isUserActiveStatus: false,
          isOngoingStatus: false,
          isPayHasAttStatus: false,
          isClassActiveStatus: false,
          isCheckPayStatus: false,
          isCheckTuteStatus: false,
        ));

  void toggleFreeCardCheck(bool freeCard) {
    final currentState = state as CheckboxButtonInitial;
    emit(CheckboxButtonInitial(
      isStudentFreeCard: freeCard,
      isStudentActiveStatus: currentState.isStudentActiveStatus,
      isTeacherActiveStatus: currentState.isTeacherActiveStatus,
      isUserActiveStatus: currentState.isUserActiveStatus,
      isOngoingStatus: currentState.isOngoingStatus,
      isPayHasAttStatus: currentState.isPayHasAttStatus,
      isClassActiveStatus: currentState.isClassActiveStatus,
      isCheckPayStatus: currentState.isCheckPayStatus,
      isCheckTuteStatus: currentState.isCheckTuteStatus,
    ));
  }

  void toggleStudentActiveStatus(bool activeStatus) {
    final currentState = state as CheckboxButtonInitial;
    emit(CheckboxButtonInitial(
      isStudentFreeCard: currentState.isStudentFreeCard,
      isStudentActiveStatus: activeStatus,
      isTeacherActiveStatus: currentState.isTeacherActiveStatus,
      isUserActiveStatus: currentState.isUserActiveStatus,
      isOngoingStatus: currentState.isOngoingStatus,
      isPayHasAttStatus: currentState.isPayHasAttStatus,
      isClassActiveStatus: currentState.isClassActiveStatus,
      isCheckPayStatus: currentState.isCheckPayStatus,
      isCheckTuteStatus: currentState.isCheckTuteStatus,
    ));
  }

  void toggleClassOngoingStatus(bool ongoingStatus) {
    final currentState = state as CheckboxButtonInitial;
    emit(CheckboxButtonInitial(
      isStudentFreeCard: currentState.isStudentFreeCard,
      isStudentActiveStatus: currentState.isStudentActiveStatus,
      isTeacherActiveStatus: currentState.isTeacherActiveStatus,
      isUserActiveStatus: currentState.isUserActiveStatus,
      isOngoingStatus: ongoingStatus,
      isPayHasAttStatus: currentState.isPayHasAttStatus,
      isClassActiveStatus: currentState.isClassActiveStatus,
      isCheckPayStatus: currentState.isCheckPayStatus,
      isCheckTuteStatus: currentState.isCheckTuteStatus,
    ));
  }

  void toggleTeacherActiveStatus(bool teacherActiveStatus) {
    final currentState = state as CheckboxButtonInitial;
    emit(CheckboxButtonInitial(
      isStudentFreeCard: currentState.isStudentFreeCard,
      isStudentActiveStatus: currentState.isStudentActiveStatus,
      isTeacherActiveStatus: teacherActiveStatus,
      isUserActiveStatus: currentState.isUserActiveStatus,
      isOngoingStatus: currentState.isOngoingStatus,
      isPayHasAttStatus: currentState.isPayHasAttStatus,
      isClassActiveStatus: currentState.isClassActiveStatus,
      isCheckPayStatus: currentState.isCheckPayStatus,
      isCheckTuteStatus: currentState.isCheckTuteStatus,
    ));
  }

  void toggleUserActiveStatus(bool userActiveStatus) {
    final currentState = state as CheckboxButtonInitial;
    emit(CheckboxButtonInitial(
      isStudentFreeCard: currentState.isStudentFreeCard,
      isStudentActiveStatus: currentState.isStudentActiveStatus,
      isTeacherActiveStatus: currentState.isTeacherActiveStatus,
      isUserActiveStatus: userActiveStatus,
      isOngoingStatus: currentState.isOngoingStatus,
      isPayHasAttStatus: currentState.isPayHasAttStatus,
      isClassActiveStatus: currentState.isClassActiveStatus,
      isCheckPayStatus: currentState.isCheckPayStatus,
      isCheckTuteStatus: currentState.isCheckTuteStatus,
    ));
  }

  void togglePayHasAttStatus(bool payHasAttStatus) {
    final currentState = state as CheckboxButtonInitial;
    emit(CheckboxButtonInitial(
      isStudentFreeCard: currentState.isStudentFreeCard,
      isStudentActiveStatus: currentState.isStudentActiveStatus,
      isTeacherActiveStatus: currentState.isTeacherActiveStatus,
      isUserActiveStatus: currentState.isUserActiveStatus,
      isOngoingStatus: currentState.isOngoingStatus,
      isPayHasAttStatus: payHasAttStatus,
      isClassActiveStatus: currentState.isClassActiveStatus,
      isCheckPayStatus: currentState.isCheckPayStatus,
      isCheckTuteStatus: currentState.isCheckTuteStatus,
    ));
  }

  void toggleClassActiveStatus(bool isClassActiveStatus) {
    final currentState = state as CheckboxButtonInitial;
    emit(CheckboxButtonInitial(
      isStudentFreeCard: currentState.isStudentFreeCard,
      isStudentActiveStatus: currentState.isStudentActiveStatus,
      isTeacherActiveStatus: currentState.isTeacherActiveStatus,
      isUserActiveStatus: currentState.isUserActiveStatus,
      isOngoingStatus: currentState.isOngoingStatus,
      isPayHasAttStatus: currentState.isPayHasAttStatus,
      isClassActiveStatus: isClassActiveStatus,
      isCheckPayStatus: currentState.isCheckPayStatus,
      isCheckTuteStatus: currentState.isCheckTuteStatus,
    ));
  }

  void toggleCheckPayStatus(bool isCheckPayStatus) {
    final currentState = state as CheckboxButtonInitial;
    emit(CheckboxButtonInitial(
      isStudentFreeCard: currentState.isStudentFreeCard,
      isStudentActiveStatus: currentState.isStudentActiveStatus,
      isTeacherActiveStatus: currentState.isTeacherActiveStatus,
      isUserActiveStatus: currentState.isUserActiveStatus,
      isOngoingStatus: currentState.isOngoingStatus,
      isPayHasAttStatus: currentState.isPayHasAttStatus,
      isClassActiveStatus: currentState.isPayHasAttStatus,
      isCheckPayStatus: isCheckPayStatus,
      isCheckTuteStatus: currentState.isCheckTuteStatus,
    ));
  }

  void toggleCheckTuteStatus(bool isCheckTuteStatus) {
    final currentState = state as CheckboxButtonInitial;
    emit(CheckboxButtonInitial(
      isStudentFreeCard: currentState.isStudentFreeCard,
      isStudentActiveStatus: currentState.isStudentActiveStatus,
      isTeacherActiveStatus: currentState.isTeacherActiveStatus,
      isUserActiveStatus: currentState.isUserActiveStatus,
      isOngoingStatus: currentState.isOngoingStatus,
      isPayHasAttStatus: currentState.isPayHasAttStatus,
      isClassActiveStatus: currentState.isPayHasAttStatus,
      isCheckPayStatus: currentState.isCheckPayStatus,
      isCheckTuteStatus: isCheckTuteStatus,
    ));
  }
}
