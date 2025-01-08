import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'radio_button_state.dart';

class RadioButtonCubit extends Cubit<RadioButtonState> {
  RadioButtonCubit()
      : super(const RadioButtonInitial(
          studentGender: Gender.male,
          teacherGender: Gender.male,
          userGender: Gender.male,
          studentAdmission: Admission.paid,
        ));

  void selectStudentGender(Gender gender) {
    final currentState = state as RadioButtonInitial;
    emit(RadioButtonInitial(
      studentGender: gender,
      teacherGender: currentState.teacherGender,
      userGender: currentState.userGender,
      studentAdmission: currentState.studentAdmission,
    ));
  }

  void selectTeacherGender(Gender gender) {
    final currentState = state as RadioButtonInitial;
    emit(RadioButtonInitial(
      studentGender: currentState.studentGender,
      teacherGender: gender,
      userGender: currentState.userGender,
      studentAdmission: currentState.studentAdmission,
    ));
  }

  void selectStudentAdmission(Admission admission) {
    final currentState = state as RadioButtonInitial;
    emit(RadioButtonInitial(
      studentGender: currentState.studentGender,
      teacherGender: currentState.teacherGender,
      userGender: currentState.userGender,
      studentAdmission: admission,
    ));
  }

  void selectUserGender(Gender gender) {
    final currentState = state as RadioButtonInitial;
    emit(RadioButtonInitial(
      studentGender: currentState.studentGender,
      teacherGender: currentState.teacherGender,
      userGender: gender,
      studentAdmission: currentState.studentAdmission,
    ));
  }
}
