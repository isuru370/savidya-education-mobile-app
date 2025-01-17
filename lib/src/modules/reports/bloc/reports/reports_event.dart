part of 'reports_bloc.dart';

sealed class ReportsEvent extends Equatable {
  const ReportsEvent();

  @override
  List<Object> get props => [];
}

final class DallyReports extends ReportsEvent {
  final String selectDate;
  const DallyReports({required this.selectDate});

  @override
  List<Object> get props => [selectDate];
}

final class MonthlyReports extends ReportsEvent {
  final String selectMonth;
  const MonthlyReports({required this.selectMonth});

  @override
  List<Object> get props => [selectMonth];
}

final class TeacherPaymentMonthlyReports extends ReportsEvent {
  final String selectMonth;
  final int teacherId;
  const TeacherPaymentMonthlyReports(
      {required this.selectMonth, required this.teacherId});

  @override
  List<Object> get props => [selectMonth, teacherId];
}

final class ClassPaymentMonthlyReports extends ReportsEvent {
  final String selectMonth;
  final int classHasCatId;
  const ClassPaymentMonthlyReports({required this.selectMonth,required this.classHasCatId});

  @override
  List<Object> get props => [selectMonth,classHasCatId];
}
