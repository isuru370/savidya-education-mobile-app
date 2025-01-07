import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'class_has_student_event.dart';
part 'class_has_student_state.dart';

class ClassHasStudentBloc extends Bloc<ClassHasStudentEvent, ClassHasStudentState> {
  ClassHasStudentBloc() : super(ClassHasStudentInitial()) {
    on<ClassHasStudentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
