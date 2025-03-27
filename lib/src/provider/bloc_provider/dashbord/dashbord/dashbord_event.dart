part of 'dashbord_bloc.dart';

sealed class DashbordEvent extends Equatable {
  const DashbordEvent();

  @override
  List<Object> get props => [];
}

class GetReport extends DashbordEvent {}

class GetPaymentReport extends DashbordEvent {}

class GetPaymentChartReport extends DashbordEvent {}
