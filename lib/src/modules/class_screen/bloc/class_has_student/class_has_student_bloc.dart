import 'package:aloka_mobile_app/src/models/student/percentage_model_class.dart';
import 'package:aloka_mobile_app/src/services/class_has_student_service.dart/class_has_student_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/student_has_category_has_class/student_has_category_has_class_model.dart';
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

          if (percentageResponse['success']) {
            final List<dynamic> percentageData =
                percentageResponse['present_data'];
            final List<PercentageModelClass> percentages = percentageData
                .map((json) => PercentageModelClass.fromJson(json))
                .toList();
            percentageList.addAll(percentages);
          } else {
            emit(ClassHasStudentFailure(
                failureMessage: percentageResponse['message']));
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
