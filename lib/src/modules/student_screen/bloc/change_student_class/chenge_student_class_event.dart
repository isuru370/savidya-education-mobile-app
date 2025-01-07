part of 'chenge_student_class_bloc.dart';

sealed class ChangeStudentClassEvent extends Equatable {
  const ChangeStudentClassEvent();

  @override
  List<Object> get props => [];
}

final class ChangeClassEvent extends ChangeStudentClassEvent {
  final StudentHasCategoryHasClassModelClass modelClass;
  const ChangeClassEvent({required this.modelClass});

  @override
  List<Object> get props => [modelClass];
}

final class DeleteClassEvent extends ChangeStudentClassEvent {
  final StudentHasCategoryHasClassModelClass modelClass;
  const DeleteClassEvent({required this.modelClass});

  @override
  List<Object> get props => [modelClass];
}
