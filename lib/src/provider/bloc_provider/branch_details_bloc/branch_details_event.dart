part of 'branch_details_bloc.dart';

sealed class BranchDetailsEvent extends Equatable {
  const BranchDetailsEvent();

  @override
  List<Object> get props => [];
}

final class GetBranchDetailsEvent extends BranchDetailsEvent {
  final int bankId;
  const GetBranchDetailsEvent({required this.bankId});
}
