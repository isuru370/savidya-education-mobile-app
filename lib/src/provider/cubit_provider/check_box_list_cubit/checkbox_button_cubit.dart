import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
    ));
  }
}
