import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/bank_details/branch_details.dart';
import '../../../services/bank_service/bank_details_service.dart';

part 'branch_details_event.dart';
part 'branch_details_state.dart';

class BranchDetailsBloc extends Bloc<BranchDetailsEvent, BranchDetailsState> {
  BranchDetailsBloc() : super(BranchDetailsInitial()) {
    on<GetBranchDetailsEvent>((event, emit) async {
      emit(GetBranchDetailsProcess());
      try {
        await getBranchDetails(event.bankId).then(
          (branchDetails) {
            if (branchDetails["success"]) {
              final List<dynamic> branchData = branchDetails['branch_data'];
              final List<BankBranchModelClass> branchDataList = branchData
                  .map((bankJson) => BankBranchModelClass.fromJson(bankJson))
                  .toList();

              emit(GetBranchDetailsSuccess(branchModelClass: branchDataList));
            } else {
              emit(GetBranchDetailsFailure(
                  failureMessage: branchDetails["message"]));
            }
          },
        );
      } catch (e) {
        emit(const GetBranchDetailsFailure(
            failureMessage: "branch details not found"));
        log(e.toString());
      }
    });
  }
}
