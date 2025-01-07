import 'package:aloka_mobile_app/src/models/admission/admission_model_class.dart';
import 'package:aloka_mobile_app/src/models/bank_details/bank_model.dart';
import 'package:aloka_mobile_app/src/models/bank_details/branch_details.dart';
import 'package:aloka_mobile_app/src/models/category/category.dart';
import 'package:aloka_mobile_app/src/models/class_schedule/class_halle_model.dart';
import 'package:aloka_mobile_app/src/models/class_schedule/class_has_category_model_class.dart';
import 'package:aloka_mobile_app/src/models/class_schedule/class_schedule.dart';
import 'package:aloka_mobile_app/src/models/student/subject.dart';
import 'package:aloka_mobile_app/src/models/teacher/teacher.dart';
import 'package:aloka_mobile_app/src/models/user/user_type_model.dart';
import 'package:equatable/equatable.dart';

import '../../../models/student/grade.dart';

class DropdownButtonState extends Equatable {
  final Grade? selectedGrade;
  final Subject? selectedSubject;
  final TeacherModelClass? selectTeacher;
  final ClassScheduleModelClass? selectClass;
  final ClassCategoryModelClass? selectCategory;
  final ClassHasCategoryModelClass? selectCatHasClass;
  final BankModelClass? selectBankName;
  final BankBranchModelClass? selectBranchName;
  final UserTypeModelClass? selectUser;
  final ClassHalleModelClass? selectHall;
  final AdmissionModelClass? selectAdmission;

  const DropdownButtonState({
    this.selectedGrade,
    this.selectedSubject,
    this.selectTeacher,
    this.selectClass,
    this.selectCategory,
    this.selectCatHasClass,
    this.selectBankName,
    this.selectBranchName,
    this.selectUser,
    this.selectHall,
    this.selectAdmission,
  });

  @override
  List<Object?> get props => [
        selectedGrade,
        selectedSubject,
        selectTeacher,
        selectClass,
        selectCategory,
        selectCatHasClass,
        selectBankName,
        selectBranchName,
        selectUser,
        selectHall,
        selectAdmission,
      ];
}
