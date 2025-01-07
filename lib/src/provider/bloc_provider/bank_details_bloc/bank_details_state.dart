part of 'bank_details_bloc.dart';

sealed class BankDetailsState extends Equatable {
  const BankDetailsState();

  @override
  List<Object> get props => [];
}

final class BankDetailsInitial extends BankDetailsState {}

final class GetBankDetailsProcess extends BankDetailsState {}

final class GetBankDetailsFailure extends BankDetailsState {
  final String failureMessage;
  const GetBankDetailsFailure({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}

final class GetBankDetailsSuccess extends BankDetailsState {
  final List<BankModelClass> bankModelClass;
  const GetBankDetailsSuccess({required this.bankModelClass});

  @override
  List<Object> get props => [bankModelClass];
}
