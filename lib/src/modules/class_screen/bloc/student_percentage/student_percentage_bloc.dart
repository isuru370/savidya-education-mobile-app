import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/student/percentage_model_class.dart';
import '../../../../services/student/students_service.dart';

part 'student_percentage_event.dart';
part 'student_percentage_state.dart';

class StudentPercentageBloc
    extends Bloc<StudentPercentageEvent, StudentPercentageState> {
  StudentPercentageBloc() : super(StudentPercentageInitial()) {
    on<GetStudentPercentageEvent>(_onGetStudentPercentageEvent);
  }

  Future<void> _onGetStudentPercentageEvent(GetStudentPercentageEvent event,
      Emitter<StudentPercentageState> emit) async {
    emit(StudentPercentageLoading());

    try {
      // Assuming `studentPercentage` is a function that fetches data
      final percentageResponse = await studentPercentage(
        event.studentId,
        event.classHasCatId,
      );

      if (percentageResponse['success']) {
        // Directly get the 'attendance_data' map
        final Map<String, dynamic> attendanceData =
            percentageResponse['attendance_data'];

        // Check if attendanceData is not null and has values
        // Convert the map to a list of one element for consistency with your original flow
        final List<PercentageModelClass> percentages = [
          PercentageModelClass.fromJson(attendanceData)
        ];

        emit(StudentPercentageSuccess(getPercentage: percentages));
            } else {
        emit(StudentPercentageFailure(
          message: percentageResponse['message'] ?? 'Failed to fetch data',
        ));
      }
    } catch (e) {
      log(e.toString());
      emit(StudentPercentageFailure(
        message: 'An error occurred: ${e.toString()}',
      ));
    }
  }
}
