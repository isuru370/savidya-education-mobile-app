import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'button_visible_state.dart';

class ButtonVisibleCubit extends Cubit<ButtonVisibleState> {
  ButtonVisibleCubit()
      : super(const ButtonVisibleInitial(
          isVisibleButton: false,
        ));

  void toggleButtonCheck(bool visible) {
    emit(ButtonVisibleInitial(
      isVisibleButton: visible,
    ));
  }
}
