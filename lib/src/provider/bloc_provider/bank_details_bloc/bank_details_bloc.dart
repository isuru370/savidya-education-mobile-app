import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/bank_details/bank_model.dart';
import '../../../services/bank_service/bank_details_service.dart';

part 'bank_details_event.dart';
part 'bank_details_state.dart';

class BankDetailsBloc extends Bloc<BankDetailsEvent, BankDetailsState> {
  BankDetailsBloc() : super(BankDetailsInitial()) {
    on<GetBankDetailsEvent>((event, emit) async {
      emit(GetBankDetailsProcess());
      try {
        await getBankDetails().then(
          (bankDetails) {
            if (bankDetails["success"]) {
              final List<dynamic> bankData = bankDetails['banks_data'];
              final List<BankModelClass> bankDataList = bankData
                  .map((bankJson) => BankModelClass.fromJson(bankJson))
                  .toList();

              emit(GetBankDetailsSuccess(bankModelClass: bankDataList));
            } else {
              emit(GetBankDetailsFailure(
                  failureMessage: bankDetails["message"]));
            }
          },
        );
      } catch (e) {
        emit(const GetBankDetailsFailure(
            failureMessage: "Bank details not found"));
        log(e.toString());
      }
    });
  }
}
