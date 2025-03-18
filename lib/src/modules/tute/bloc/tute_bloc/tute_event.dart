part of 'tute_bloc.dart';

@immutable
sealed class TuteEvent extends Equatable {
  const TuteEvent();
  @override
  List<Object?> get props => [];
}

final class InsertTuteEvent extends TuteEvent {
  final TuteModelClass tuteModelClass;
  const InsertTuteEvent({required this.tuteModelClass});

  @override
  List<Object?> get props => [tuteModelClass];
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
