import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
