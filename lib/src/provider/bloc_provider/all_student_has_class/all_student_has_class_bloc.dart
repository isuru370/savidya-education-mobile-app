import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/student_has_category_has_class/student_has_category_has_class_model.dart';
import '../../../services/student/students_service.dart';

part 'all_student_has_class_event.dart';
part 'all_student_has_class_state.dart';

class AllStudentHasClassBloc
    extends Bloc<AllStudentHasClassEvent, AllStudentHasClassState> {
  AllStudentHasClassBloc() : super(AllStudentHasClassInitial()) {
    on<GetAllStudentHasClass>((event, emit) async {
      emit(AllStudentHasClassProcess());

      try {
        // Fetch the student-class data
        final result = await getAllStudentHasClass();

        if (result['success']) {
          final List<dynamic> classStudentData = result['student_has_class'];
          final List<StudentHasCategoryHasClassModelClass> classStudentList =
              classStudentData
                  .map((studentClassJson) =>
                      StudentHasCategoryHasClassModelClass.fromJson(studentClassJson))
                  .toList();

          // Emit success state with parsed data
          emit(AllStudentHasClassSuccess(studentHasClassList: classStudentList));
        } else {
          // Emit failure state with API error message
          final errorMessage = result['message'] ?? 'Unknown error occurred';
          emit(AllStudentHasClassFailure(errorMessage: errorMessage));
        }
      } catch (e, stackTrace) {
        // Log the exception and emit a failure state
        log('Error in GetAllStudentHasClass: $e', stackTrace: stackTrace);
        emit(const AllStudentHasClassFailure(
            errorMessage: "Failed to fetch data. Please try again later."));
      }
    });
  }
}
