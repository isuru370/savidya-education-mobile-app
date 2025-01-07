import 'package:equatable/equatable.dart';

class UserModeData extends Equatable {
  final bool userMode;

  const UserModeData({
    required this.userMode,
  });

  @override
  List<Object?> get props => [userMode];
}
