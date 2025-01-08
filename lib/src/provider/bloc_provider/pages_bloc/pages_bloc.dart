import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/page_model/page_model.dart';
import '../../../services/permissions_service/permissions_service.dart';

part 'pages_event.dart';
part 'pages_state.dart';

class PagesBloc extends Bloc<PagesEvent, PagesState> {
  PagesBloc() : super(PagesInitial()) {
    on<GetPagesEvent>((event, emit) async {
      emit(PagesProcess());
      try {
        await getPages().then(
          (pages) {
            if (pages['success']) {
              final List<dynamic> pagesData = pages['pages'];
              final List<PageModel> pageList = pagesData
                  .map((pageJson) => PageModel.fromJson(pageJson))
                  .toList();
              emit(PagesSuccess(pageList: pageList));
            } else {
              emit(PageFailure(failureMessage: pages['message']));
            }
          },
        );
      } catch (e) {
        emit(const PageFailure(
            failureMessage: "Exception : Failed to fetch page data"));
        log(e.toString());
      }
    });
  }
}
