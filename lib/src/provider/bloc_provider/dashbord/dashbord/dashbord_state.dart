part of 'dashbord_bloc.dart';

sealed class DashbordState extends Equatable {
  const DashbordState();

  @override
  List<Object> get props => [];
}

final class DashbordInitial extends DashbordState {}

final class DashbordProcess extends DashbordState {}

final class DashbordFailure extends DashbordState {
  final String errorMSG;
  const DashbordFailure({required this.errorMSG});

  @override
  List<Object> get props => [errorMSG];
}

final class DashbordReport extends DashbordState {
  final int activeStudentCount;
  final int inactiveStudentCount;
  final int activeTeacherCount;
  final int inactiveTeacherCount;
  final int activeClassCount;
  final int inactiveClassCount;
  final int deleteClassCount;
  const DashbordReport({
    required this.activeStudentCount,
    required this.inactiveStudentCount,
    required this.activeTeacherCount,
    required this.inactiveTeacherCount,
    required this.activeClassCount,
    required this.inactiveClassCount,
    required this.deleteClassCount,
  });

  @override
  List<Object> get props => [
        activeStudentCount,
        inactiveStudentCount,
        activeTeacherCount,
        inactiveTeacherCount,
        activeClassCount,
        inactiveClassCount,
        deleteClassCount,
      ];
}

final class DashbordPaymentReport extends DashbordState {
  final double dallyAmont;
  final double monthlyAmount;
  final double yearllyAmount;
  const DashbordPaymentReport(
      {required this.dallyAmont,
      required this.monthlyAmount,
      required this.yearllyAmount});

  @override
  List<Object> get props => [
        dallyAmont,
        monthlyAmount,
        yearllyAmount,
      ];
}

final class DashbordPaymentChartReport extends DashbordState {
  final List<Map<String, dynamic>> dallyAmont;
  final List<Map<String, dynamic>> monthlyAmount;
  final List<Map<String, dynamic>> yearllyAmount;
  const DashbordPaymentChartReport(
      {required this.dallyAmont,
      required this.monthlyAmount,
      required this.yearllyAmount});

  @override
  List<Object> get props => [
        dallyAmont,
        monthlyAmount,
        yearllyAmount,
      ];
}
