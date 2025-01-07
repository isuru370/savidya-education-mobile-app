part of 'radio_button_cubit.dart';

enum Gender { male, female }

enum Admission { paid, notPaid }

sealed class RadioButtonState extends Equatable {
  const RadioButtonState();

  @override
  List<Object> get props => [];
}

final class RadioButtonInitial extends RadioButtonState {
  final Gender studentGender;
  final Gender teacherGender;
  final Gender userGender;
  final Admission studentAdmission;
  const RadioButtonInitial({
    required this.studentGender,
    required this.teacherGender,
    required this.studentAdmission,
    required this.userGender,
  });

  @override
  List<Object> get props => [
        studentGender,
        teacherGender,
        userGender,
        studentAdmission,
      ];
}
