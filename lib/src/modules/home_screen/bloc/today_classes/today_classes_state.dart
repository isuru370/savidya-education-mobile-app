part of 'today_classes_bloc.dart';

@immutable
sealed class TodayClassesState extends Equatable {
  const TodayClassesState();
  @override
  List<Object?> get props => [];
}

final class TodayClassesInitial extends TodayClassesState {}

final class TodayClassesProcess extends TodayClassesState {}

final class TodayClassesFailure extends TodayClassesState {
  final String failureMSG;
  const TodayClassesFailure({required this.failureMSG});

  @override
  List<Object?> get props => [failureMSG];

}

final class TodayClassesSuccess extends TodayClassesState {
    final List<TodayClassesModel> todayClassesModel;
  const TodayClassesSuccess({required this.todayClassesModel});
  
  @override
  List<Object?> get props => [todayClassesModel];
}
