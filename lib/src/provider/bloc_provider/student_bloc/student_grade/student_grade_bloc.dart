import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/student/grade.dart';
import '../../../../services/student/grade_service.dart';

part 'student_grade_event.dart';
part 'student_grade_state.dart';

class StudentGradeBloc extends Bloc<StudentGradeEvent, StudentGradeState> {
  StudentGradeBloc() : super(StudentGradeInitial()) {
    on<GetStudentGrade>((event, emit) async {
      try {
        await getGrade().then(
          (gradesResponse) {
            if (gradesResponse['success']) {
              final List<dynamic> gradesData = gradesResponse['grades'];
              final List<Grade> gradeList = gradesData
                  .map((gradeJson) => Grade.fromJson(gradeJson))
                  .toList();

              emit(GetStudentGradeSuccess(getGradeList: gradeList));
            } else {
              if (gradesResponse['message'] == 'Failed to fetch grades') {
                emit(
                    GetStudentGradeFailure(message: gradesResponse['message']));
              } else if (gradesResponse['message'] == 'No grades available') {
                emit(const GetStudentGradeFailure(
                    message: 'There is no data in the database'));
              } else {
                emit(
                    GetStudentGradeFailure(message: gradesResponse['message']));
              }
            }
          },
        );
      } catch (e) {
        emit(GetStudentGradeFailure(message: e.toString()));
      }
    });
  }
}
