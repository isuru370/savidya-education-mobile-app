part of 'pages_bloc.dart';

sealed class PagesEvent extends Equatable {
  const PagesEvent();

  @override
  List<Object> get props => [];
}

final class GetPagesEvent extends PagesEvent{}
