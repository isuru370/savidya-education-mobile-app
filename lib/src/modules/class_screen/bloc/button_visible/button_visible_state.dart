part of 'button_visible_cubit.dart';

sealed class ButtonVisibleState extends Equatable {
  const ButtonVisibleState();

  @override
  List<Object> get props => [];
}

final class ButtonVisibleInitial extends ButtonVisibleState {
  final bool isVisibleButton;
  const ButtonVisibleInitial({required this.isVisibleButton});

    @override
  List<Object> get props => [isVisibleButton];
}
