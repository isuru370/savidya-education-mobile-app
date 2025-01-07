part of 'bank_details_bloc.dart';

sealed class BankDetailsEvent extends Equatable {
  const BankDetailsEvent();

  @override
  List<Object> get props => [];
}

final class GetBankDetailsEvent extends BankDetailsEvent {}
