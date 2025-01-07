part of 'checkbox_button_cubit.dart';

sealed class CheckboxButtonState extends Equatable {
  const CheckboxButtonState();

  @override
  List<Object> get props => [];
}

final class CheckboxButtonInitial extends CheckboxButtonState {
  final bool isStudentFreeCard;
  final bool isStudentActiveStatus;
  final bool isTeacherActiveStatus;
  final bool isUserActiveStatus;
  final bool isOngoingStatus;
  final bool isPayHasAttStatus;
  final bool isClassActiveStatus;
  final bool isCheckPayStatus;
  const CheckboxButtonInitial({
    required this.isStudentFreeCard,
    required this.isStudentActiveStatus,
    required this.isTeacherActiveStatus,
    required this.isUserActiveStatus,
    required this.isOngoingStatus,
    required this.isPayHasAttStatus,
    required this.isClassActiveStatus,
    required this.isCheckPayStatus,
  });

  @override
  List<Object> get props => [
        isStudentFreeCard,
        isStudentActiveStatus,
        isTeacherActiveStatus,
        isUserActiveStatus,
        isOngoingStatus,
        isPayHasAttStatus,
        isClassActiveStatus,
        isCheckPayStatus,
      ];
}
