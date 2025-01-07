part of 'pages_bloc.dart';

sealed class PagesState extends Equatable {
  const PagesState();

  @override
  List<Object> get props => [];
}

final class PagesInitial extends PagesState {}

final class PagesProcess extends PagesState {}

final class PageFailure extends PagesState {
  final String failureMessage;
  const PageFailure({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}

final class PagesSuccess extends PagesState {
  final List<PageModel> pageList;
  const PagesSuccess({required this.pageList});

  @override
  List<Object> get props => [pageList];
}
