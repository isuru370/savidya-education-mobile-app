part of 'branch_details_bloc.dart';

sealed class BranchDetailsState extends Equatable {
  const BranchDetailsState();
  
  @override
  List<Object> get props => [];
}

final class BranchDetailsInitial extends BranchDetailsState {}

final class GetBranchDetailsProcess extends BranchDetailsState {}

final class GetBranchDetailsFailure extends BranchDetailsState {
  final String failureMessage;
  const GetBranchDetailsFailure({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}

final class GetBranchDetailsSuccess extends BranchDetailsState {
  final List<BankBranchModelClass> branchModelClass;
  const GetBranchDetailsSuccess({required this.branchModelClass});

  @override
  List<Object> get props => [branchModelClass];
}

