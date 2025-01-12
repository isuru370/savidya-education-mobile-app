import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/student/percentage_model_class.dart';
import '../../../../models/student_has_category_has_class/student_has_category_has_class_model.dart';
import '../../../../services/class_has_student_service.dart/class_has_student_service.dart';
import '../../../../services/student/students_service.dart';

part 'class_has_student_event.dart';
part 'class_has_student_state.dart';

class ClassHasStudentBloc
    extends Bloc<ClassHasStudentEvent, ClassHasStudentState> {
  ClassHasStudentBloc() : super(ClassHasStudentInitial()) {
    on<GetClassHasStudentUniqueClassEvent>(
        _onGetClassHasStudentUniqueClassEvent);
  }

  Future<void> _onGetClassHasStudentUniqueClassEvent(
      GetClassHasStudentUniqueClassEvent event,
      Emitter<ClassHasStudentState> emit) async {
    emit(ClassHasStudentProcess());

    try {
      final getUniqueClassHasStudent =
          await getUniqueStudentClass(event.studentId);

      if (getUniqueClassHasStudent['success']) {
        final List<dynamic> uniqueStudentHasClassData =
            getUniqueClassHasStudent['student_has_unique_class'];

        final List<StudentHasCategoryHasClassModelClass>
            classHasUniqueStudentList = [];
        final List<PercentageModelClass> percentageList = [];

        for (var classData in uniqueStudentHasClassData) {
          final percentageResponse = await studentPercentage(
              event.studentId,
              classData['classHasCatId'] is String
                  ? int.parse(classData['classHasCatId'])
                  : classData['classHasCatId']);

          final Map<String, dynamic>? attendanceData =
              percentageResponse['attendance_data'];

          if (attendanceData == null) {
            emit(const ClassHasStudentFailure(
                failureMessage: "Attendance data is null"));
            return;
          }

          try {
            final PercentageModelClass percentage =
                PercentageModelClass.fromJson(attendanceData);
            percentageList.add(percentage);
          } catch (e) {
            emit(ClassHasStudentFailure(
                failureMessage:
                    "Failed to parse attendance data: ${e.toString()}"));
            return;
          }
        }

        classHasUniqueStudentList.addAll(uniqueStudentHasClassData
            .map((classHasStuJson) =>
                StudentHasCategoryHasClassModelClass.fromJson(classHasStuJson))
            .toList());

        emit(GetClassHasStudentUniqueData(
          getUniqueStudent: classHasUniqueStudentList,
          getPercentage: percentageList,
        ));
      } else {
        emit(ClassHasStudentFailure(
            failureMessage: getUniqueClassHasStudent['message']));
      }
    } catch (e) {
      emit(ClassHasStudentFailure(failureMessage: e.toString()));
    }
  }
}
