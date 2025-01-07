part of 'class_halls_bloc.dart';

sealed class ClassHallsEvent extends Equatable {
  const ClassHallsEvent();

  @override
  List<Object> get props => [];
}

final class GetClassHallsEvent extends ClassHallsEvent{}
