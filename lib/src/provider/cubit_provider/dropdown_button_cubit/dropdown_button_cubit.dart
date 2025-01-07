import 'package:aloka_mobile_app/src/models/bank_details/bank_model.dart';
import 'package:aloka_mobile_app/src/models/bank_details/branch_details.dart';
import 'package:aloka_mobile_app/src/models/class_schedule/class_halle_model.dart';
import 'package:aloka_mobile_app/src/models/user/user_type_model.dart';
import 'package:bloc/bloc.dart';

import '../../../models/admission/admission_model_class.dart';
import '../../../models/category/category.dart';
import '../../../models/class_schedule/class_has_category_model_class.dart';
import '../../../models/class_schedule/class_schedule.dart';
import '../../../models/student/grade.dart';
import '../../../models/student/subject.dart';
import '../../../models/teacher/teacher.dart';
import 'dropdown_button_state.dart';

class DropdownButtonCubit extends Cubit<DropdownButtonState> {
  DropdownButtonCubit()
      : super(const DropdownButtonState(
            selectedGrade: null,
            selectedSubject: null,
            selectTeacher: null,
            selectClass: null,
            selectCategory: null,
            selectCatHasClass: null,
            selectBankName: null,
            selectBranchName: null,
            selectUser: null,
            selectHall: null,
            selectAdmission: null));

  void selectGrade(Grade? grade) {
    emit(DropdownButtonState(
      selectedGrade: grade,
      selectedSubject: state.selectedSubject,
      selectTeacher: state.selectTeacher,
      selectClass: state.selectClass,
      selectCategory: state.selectCategory,
      selectCatHasClass: state.selectCatHasClass,
      selectBankName: state.selectBankName,
      selectBranchName: state.selectBranchName,
      selectUser: state.selectUser,
      selectHall: state.selectHall,
      selectAdmission: state.selectAdmission,
    ));
  }

  void selectSubject(Subject? subject) {
    emit(DropdownButtonState(
      selectedGrade: state.selectedGrade,
      selectedSubject: subject,
      selectTeacher: state.selectTeacher,
      selectClass: state.selectClass,
      selectCategory: state.selectCategory,
      selectCatHasClass: state.selectCatHasClass,
      selectBankName: state.selectBankName,
      selectBranchName: state.selectBranchName,
      selectUser: state.selectUser,
      selectHall: state.selectHall,
      selectAdmission: state.selectAdmission,
    ));
  }

  void selectTeacher(TeacherModelClass? teacher) {
    emit(DropdownButtonState(
      selectedGrade: state.selectedGrade,
      selectedSubject: state.selectedSubject,
      selectTeacher: teacher,
      selectClass: state.selectClass,
      selectCategory: state.selectCategory,
      selectCatHasClass: state.selectCatHasClass,
      selectBankName: state.selectBankName,
      selectBranchName: state.selectBranchName,
      selectUser: state.selectUser,
      selectHall: state.selectHall,
      selectAdmission: state.selectAdmission,
    ));
  }

  void selectClass(ClassScheduleModelClass? studentClass) {
    emit(DropdownButtonState(
      selectedGrade: state.selectedGrade,
      selectedSubject: state.selectedSubject,
      selectTeacher: state.selectTeacher,
      selectClass: studentClass,
      selectCategory: state.selectCategory,
      selectCatHasClass: state.selectCatHasClass,
      selectBankName: state.selectBankName,
      selectBranchName: state.selectBranchName,
      selectUser: state.selectUser,
      selectHall: state.selectHall,
      selectAdmission: state.selectAdmission,
    ));
  }

  void selectCategory(ClassCategoryModelClass? selectCat) {
    emit(DropdownButtonState(
      selectedGrade: state.selectedGrade,
      selectedSubject: state.selectedSubject,
      selectTeacher: state.selectTeacher,
      selectClass: state.selectClass,
      selectCategory: selectCat,
      selectCatHasClass: state.selectCatHasClass,
      selectBankName: state.selectBankName,
      selectBranchName: state.selectBranchName,
      selectUser: state.selectUser,
      selectHall: state.selectHall,
      selectAdmission: state.selectAdmission,
    ));
  }

  void selectClassHasCategory(ClassHasCategoryModelClass? selectCatHasClass) {
    emit(DropdownButtonState(
      selectedGrade: state.selectedGrade,
      selectedSubject: state.selectedSubject,
      selectTeacher: state.selectTeacher,
      selectClass: state.selectClass,
      selectCategory: state.selectCategory,
      selectCatHasClass: selectCatHasClass,
      selectBankName: state.selectBankName,
      selectBranchName: state.selectBranchName,
      selectUser: state.selectUser,
      selectHall: state.selectHall,
      selectAdmission: state.selectAdmission,
    ));
  }

  void selectBank(BankModelClass? selectBankName) {
    emit(DropdownButtonState(
      selectedGrade: state.selectedGrade,
      selectedSubject: state.selectedSubject,
      selectTeacher: state.selectTeacher,
      selectClass: state.selectClass,
      selectCategory: state.selectCategory,
      selectCatHasClass: state.selectCatHasClass,
      selectBankName: selectBankName,
      selectBranchName: state.selectBranchName,
      selectUser: state.selectUser,
      selectHall: state.selectHall,
      selectAdmission: state.selectAdmission,
    ));
  }

  void selectBranch(BankBranchModelClass? selectBranchName) {
    emit(DropdownButtonState(
      selectedGrade: state.selectedGrade,
      selectedSubject: state.selectedSubject,
      selectTeacher: state.selectTeacher,
      selectClass: state.selectClass,
      selectCategory: state.selectCategory,
      selectCatHasClass: state.selectCatHasClass,
      selectBankName: state.selectBankName,
      selectBranchName: selectBranchName,
      selectUser: state.selectUser,
      selectHall: state.selectHall,
      selectAdmission: state.selectAdmission,
    ));
  }

  void selectUser(UserTypeModelClass? selectUser) {
    emit(DropdownButtonState(
      selectedGrade: state.selectedGrade,
      selectedSubject: state.selectedSubject,
      selectTeacher: state.selectTeacher,
      selectClass: state.selectClass,
      selectCategory: state.selectCategory,
      selectCatHasClass: state.selectCatHasClass,
      selectBankName: state.selectBankName,
      selectBranchName: state.selectBranchName,
      selectUser: selectUser,
      selectHall: state.selectHall,
      selectAdmission: state.selectAdmission,
    ));
  }

  void selectHall(ClassHalleModelClass? selectHall) {
    emit(DropdownButtonState(
      selectedGrade: state.selectedGrade,
      selectedSubject: state.selectedSubject,
      selectTeacher: state.selectTeacher,
      selectClass: state.selectClass,
      selectCategory: state.selectCategory,
      selectCatHasClass: state.selectCatHasClass,
      selectBankName: state.selectBankName,
      selectBranchName: state.selectBranchName,
      selectUser: state.selectUser,
      selectHall: selectHall,
      selectAdmission: state.selectAdmission,
    ));
  }

  void selectAdmission(AdmissionModelClass? selectAdmission) {
    emit(DropdownButtonState(
      selectedGrade: state.selectedGrade,
      selectedSubject: state.selectedSubject,
      selectTeacher: state.selectTeacher,
      selectClass: state.selectClass,
      selectCategory: state.selectCategory,
      selectCatHasClass: state.selectCatHasClass,
      selectBankName: state.selectBankName,
      selectBranchName: state.selectBranchName,
      selectUser: state.selectUser,
      selectHall: state.selectHall,
      selectAdmission: selectAdmission,
    ));
  }
}
