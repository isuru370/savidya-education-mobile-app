part of 'tute_bloc.dart';

@immutable
sealed class TuteEvent extends Equatable {
  const TuteEvent();
  @override
  List<Object?> get props => [];
}

final class InsertTuteEvent extends TuteEvent {
  final int studentId;
  final int classCategoryId;
  final String tuteFor;
  const InsertTuteEvent({
    required this.studentId,
    required this.classCategoryId,
    required this.tuteFor,
  });

  @override
  List<Object?> get props => [studentId,classCategoryId,tuteFor];
}

final class UpdateTuteEvent extends TuteEvent {
  final TuteModelClass tuteModelClass;
  const UpdateTuteEvent({required this.tuteModelClass});

  @override
  List<Object?> get props => [tuteModelClass];
}

final class ClassCategoryTuteEvent extends TuteEvent {
  final int studentId;
  final int classCategoryId;
  const ClassCategoryTuteEvent({
    required this.studentId,
    required this.classCategoryId,
  });

  @override
  List<Object?> get props => [
        studentId,
        classCategoryId,
      ];
}

final class CheckStudentTuteEvent extends TuteEvent {
  final int studentId;
  final int classCategoryId;
  final String tuteFor;
  const CheckStudentTuteEvent({
    required this.studentId,
    required this.classCategoryId,
    required this.tuteFor,
  });

  @override
  List<Object?> get props => [
        studentId,
        classCategoryId,
        tuteFor,
      ];
}

final class CheckStudentTuteCountEvent extends TuteEvent {
  final String tuteFor;
  final int studentId;
  final int studentStudentClassId;
  final int classCategoryId;

  const CheckStudentTuteCountEvent({
    required this.tuteFor,
    required this.studentId,
    required this.studentStudentClassId,
    required this.classCategoryId,
  });

  @override
  List<Object?> get props => [
        tuteFor,
        studentId,
        studentStudentClassId,
        classCategoryId,
      ];
}
