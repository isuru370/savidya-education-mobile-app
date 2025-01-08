import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/category/category.dart';
import '../../../../services/category/category_service.dart';

part 'class_category_event.dart';
part 'class_category_state.dart';

class ClassCategoryBloc extends Bloc<ClassCategoryEvent, ClassCategoryState> {
  ClassCategoryBloc() : super(ClassCategoryInitial()) {
    on<GetClassCategory>((event, emit) async {
      emit(ClassCategoryProcess());
      try {
        await getClassCategory().then(
          (getCategory) {
            if (getCategory['success']) {
              final List<dynamic> categoryData = getCategory['category_data'];
              final List<ClassCategoryModelClass> classCategoryList =
                  categoryData
                      .map((categoryJson) =>
                          ClassCategoryModelClass.fromJson(categoryJson))
                      .toList();
              emit(ClassCategorySuccess(classCategoryList: classCategoryList));
            } else {
              if (getCategory['message'] == 'Failed to fetch category') {
                emit(const ClassCategorySuccess(classCategoryList: []));
              } else {
                emit(ClassCategoryFailure(
                    failureMessage: getCategory['message']));
              }
            }
          },
        );
      } catch (e) {
        emit(ClassCategoryFailure(failureMessage: e.toString()));
      }
    });
  }
}
