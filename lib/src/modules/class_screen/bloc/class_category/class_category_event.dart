part of 'class_category_bloc.dart';

sealed class ClassCategoryEvent extends Equatable {
  const ClassCategoryEvent();

  @override
  List<Object> get props => [];
}

final class GetClassCategory extends ClassCategoryEvent {}
