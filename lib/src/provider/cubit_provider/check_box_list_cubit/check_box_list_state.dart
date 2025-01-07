part of 'check_box_list_cubit.dart';

sealed class CheckBoxListState extends Equatable {
  const CheckBoxListState();

  @override
  List<Object> get props => [];
}

final class CheckBoxListInitial extends CheckBoxListState {
  final List<bool> isPayHasAttStatusList;
  const CheckBoxListInitial({required this.isPayHasAttStatusList});

  @override
  List<Object> get props => [isPayHasAttStatusList];
}
