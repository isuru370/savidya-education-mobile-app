import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'check_box_list_state.dart';

class CheckBoxListCubit extends Cubit<CheckBoxListState> {
  CheckBoxListCubit(int length)
      : super(CheckBoxListInitial(
          isPayHasAttStatusList: List.filled(length, false),
        ));

  void togglePayHasAttStatus(int index, bool value) {
    final currentState = state as CheckBoxListInitial;
    final updatedList = List<bool>.from(currentState.isPayHasAttStatusList);
    updatedList[index] = value;
    emit(CheckBoxListInitial(isPayHasAttStatusList: updatedList));
  }
}
