part of 'class_bloc_bloc.dart';

sealed class ClassBlocEvent extends Equatable {
  const ClassBlocEvent();

  @override
  List<Object> get props => [];
}

class InsertClassData extends ClassBlocEvent {
  final ClassScheduleModelClass studentClassModel;
  const InsertClassData({required this.studentClassModel});
}

class UpdateClassDataEvent extends ClassBlocEvent {
  final ClassScheduleModelClass studentClassModel;
  const UpdateClassDataEvent({required this.studentClassModel});
}

class GetActiveClass extends ClassBlocEvent {}

class GetOngoingClass extends ClassBlocEvent {}
