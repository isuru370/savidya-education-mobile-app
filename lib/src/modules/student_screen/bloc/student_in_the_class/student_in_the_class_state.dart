part of 'student_in_the_class_bloc.dart';

@immutable
sealed class StudentInTheClassState extends Equatable {
  const StudentInTheClassState();

  @override
  List<Object?> get props => [];
}

final class StudentInTheClassInitial extends StudentInTheClassState {}

final class StudentInTheClassProcess extends StudentInTheClassState {}

final class StudentInTheClassFailure extends StudentInTheClassState {
  final String failureMessage;
  const StudentInTheClassFailure({required this.failureMessage});

   @override
  List<Object?> get props => [failureMessage];
}

final class StudentInTheClassSuccess extends StudentInTheClassState {
  final List<StudentsInTheClassModel> studentInTheClassModel;
  const StudentInTheClassSuccess({required this.studentInTheClassModel});

  @override
  List<Object?> get props => [studentInTheClassModel];
}
