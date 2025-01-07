import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/student/subject.dart';
import '../../../../services/student/subject_service.dart';

part 'student_subject_event.dart';
part 'student_subject_state.dart';

class StudentSubjectBloc extends Bloc<StudentSubjectEvent, StudentSubjectState> {
  StudentSubjectBloc() : super(StudentSubjectInitial()) {
    on<GetStudentSubject>((event, emit) async {
      try {
        await getSubject().then(
          (gradesResponse) {
            if (gradesResponse['success']) {
              final List<dynamic> subjectData = gradesResponse['subjects'];
              final List<Subject> subjectList = subjectData
                  .map((gradeJson) => Subject.fromJson(gradeJson))
                  .toList();

              emit(GetStudentSubjectSuccess(getSubjectList: subjectList));
            } else {
              if (gradesResponse['message'] == 'Failed to fetch subjects') {
                emit(GetStudentSubjectFailure(message: gradesResponse['message']));
              } else if (gradesResponse['message'] == 'No subjects available') {
                emit(const GetStudentSubjectFailure(
                    message: 'There is no data in the database'));
              } else {
                emit(GetStudentSubjectFailure(message: gradesResponse['message']));
              }
            }
          },
        );
      } catch (e) {
        emit(GetStudentSubjectFailure(message: e.toString()));
      }
    });
  }
}
