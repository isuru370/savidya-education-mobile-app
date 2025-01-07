import 'package:aloka_mobile_app/src/modules/admission_screen/bloc/admission/admission_bloc.dart';
import 'package:aloka_mobile_app/src/modules/admission_screen/bloc/get_admission/get_admission_bloc.dart';
import 'package:aloka_mobile_app/src/modules/admission_screen/bloc/admission_payment/admission_payment_bloc.dart';
import 'package:aloka_mobile_app/src/modules/attendance/bloc/attendance_count/attendance_count_bloc.dart';
import 'package:aloka_mobile_app/src/modules/attendance/bloc/class_student_attendance/class_student_attendance_bloc.dart';
import 'package:aloka_mobile_app/src/modules/attendance/bloc/new_attendance_read/new_attendance_read_bloc.dart';
import 'package:aloka_mobile_app/src/modules/attendance/bloc/unique_attendance/unique_attendance_bloc.dart';
import 'package:aloka_mobile_app/src/modules/auth_screen/bloc/reset_password/reset_password_bloc.dart';
import 'package:aloka_mobile_app/src/modules/auth_screen/bloc/user_type_bloc/user_type_bloc.dart';
import 'package:aloka_mobile_app/src/modules/class_screen/bloc/class_hall_bloc/class_halls_bloc.dart';
import 'package:aloka_mobile_app/src/modules/home_screen/bloc/today_classes/today_classes_bloc.dart';
import 'package:aloka_mobile_app/src/modules/payment/bloc/get_payment/get_payment_bloc.dart';
import 'package:aloka_mobile_app/src/modules/payment/bloc/payment_monthly_report/payment_monthly_report_bloc.dart';
import 'package:aloka_mobile_app/src/modules/student_screen/bloc/change_student_class/chenge_student_class_bloc.dart';
import 'package:aloka_mobile_app/src/modules/teacher_screen/bloc/teacher_class_category/teacher_class_category_bloc.dart';
import 'package:aloka_mobile_app/src/provider/bloc_provider/bank_details_bloc/bank_details_bloc.dart';
import 'package:aloka_mobile_app/src/provider/bloc_provider/branch_details_bloc/branch_details_bloc.dart';
import 'package:aloka_mobile_app/src/provider/bloc_provider/pages_bloc/pages_bloc.dart';
import 'package:aloka_mobile_app/src/provider/bloc_provider/permission_bloc/permission_bloc.dart';
import 'package:aloka_mobile_app/src/provider/cubit_provider/qr_scanner_cubit/qr_scanner_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/modules/attendance/bloc/update_attendance/update_attendance_bloc.dart';
import 'src/modules/auth_screen/bloc/user_bloc/user_login_bloc.dart';
import 'src/modules/camera_screen/bloc/crop_image/crop_image_bloc.dart';
import 'src/modules/camera_screen/bloc/quick_image/quick_image_bloc.dart';
import 'src/modules/class_screen/bloc/student_percentage/student_percentage_bloc.dart';
import 'src/modules/home_screen/bloc/quick_camera/quick_camera_bloc.dart';
import 'src/modules/payment/bloc/student_half_payment/student_half_payment_bloc.dart';
import 'src/modules/student_screen/bloc/image_picker/image_picker_bloc.dart';
import 'src/modules/student_screen/bloc/student_in_the_class/student_in_the_class_bloc.dart';
import 'src/provider/bloc_provider/all_student_has_class/all_student_has_class_bloc.dart';
import 'src/provider/bloc_provider/date_picker_bloc/date_picker_bloc.dart';
import 'src/provider/bloc_provider/theme_bloc/theme_bloc.dart';
import 'src/provider/cubit_provider/check_box_list_cubit/checkbox_button_cubit.dart';
import 'src/provider/cubit_provider/dropdown_button_cubit/dropdown_button_cubit.dart';
import 'src/provider/cubit_provider/radio_button_cubit/radio_button_cubit.dart';
import 'src/res/themes/app_mode.dart';
import 'src/routes/app_route.dart';

import 'src/modules/class_screen/bloc/button_visible/button_visible_cubit.dart';
import 'src/modules/class_screen/bloc/class_attendance/class_attendance_bloc.dart';
import 'src/modules/class_screen/bloc/class_bloc/class_bloc_bloc.dart';
import 'src/modules/class_screen/bloc/class_category/class_category_bloc.dart';
import 'src/modules/class_screen/bloc/class_has_category/class_has_category_bloc.dart';
import 'src/modules/class_screen/bloc/class_has_student/class_has_student_bloc.dart';
import 'src/modules/class_screen/bloc/days_bloc/days_bloc.dart';
import 'src/modules/payment/bloc/student_payment/student_payment_bloc.dart';
import 'src/modules/qr_code_screen/bloc/QRScanner/qr_scanner_bloc.dart';
import 'src/modules/student_screen/bloc/get_student/get_student_bloc.dart';
import 'src/modules/student_screen/bloc/manage_student_bloc/manage_student_bloc.dart';
import 'src/modules/teacher_screen/bloc/experience_year_bloc/experience_year_bloc.dart';
import 'src/modules/teacher_screen/bloc/teacher_bloc/teacher_bloc.dart';
import 'src/provider/bloc_provider/student_bloc/student_grade/student_grade_bloc.dart';
import 'src/provider/bloc_provider/student_bloc/student_subject/student_subject_bloc.dart';
import 'src/provider/cubit_provider/check_box_list_cubit/check_box_list_cubit.dart';
import 'src/provider/cubit_provider/time_cubit/time_cubit.dart';

class AlokaMobileView extends StatelessWidget {
  const AlokaMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBloc()),
        BlocProvider(create: (_) => UserLoginBloc()),
        BlocProvider(create: (_) => QuickCameraBloc()),
        BlocProvider(create: (_) => QrScannerCubit()),
        BlocProvider(create: (_) => CropImageBloc()),
        BlocProvider(create: (_) => QuickImageBloc()),
        BlocProvider(create: (_) => ImagePickerBloc()),
        BlocProvider(create: (_) => StudentGradeBloc()),
        BlocProvider(create: (_) => StudentSubjectBloc()),
        BlocProvider(create: (_) => TimeCubit()),
        BlocProvider(create: (_) => DatePickerBloc()),
        BlocProvider(create: (_) => RadioButtonCubit()),
        BlocProvider(create: (_) => DropdownButtonCubit()),
        BlocProvider(create: (_) => CheckboxButtonCubit()),
        BlocProvider(create: (_) => CheckBoxListCubit(0)),
        BlocProvider(create: (_) => ButtonVisibleCubit()),
        BlocProvider(create: (_) => ManageStudentBloc()),
        BlocProvider(create: (_) => GetStudentBloc()),
        BlocProvider(create: (_) => ClassHasStudentBloc()),
        BlocProvider(create: (_) => DaysBloc()..add(LoadDays())),
        BlocProvider(create: (_) => TeacherBloc()),
        BlocProvider(create: (_) => ClassBlocBloc()),
        BlocProvider(
            create: (_) => ExperienceYearBloc()..add(LoadExperienceYear())),
        BlocProvider(create: (_) => QrScannerBloc()),
        BlocProvider(create: (_) => ClassAttendanceBloc()),
        BlocProvider(create: (_) => StudentPaymentBloc()),
        BlocProvider(
            create: (_) => ClassCategoryBloc()..add(GetClassCategory())),
        BlocProvider(create: (_) => ClassHasCategoryBloc()),
        BlocProvider(create: (_) => ResetPasswordBloc()),
        BlocProvider(
            create: (_) => BankDetailsBloc()..add(GetBankDetailsEvent())),
        BlocProvider(create: (_) => BranchDetailsBloc()),
        BlocProvider(create: (_) => UserTypeBloc()..add(GetUserTypeEvent())),
        BlocProvider(
            create: (_) => ClassHallsBloc()..add(GetClassHallsEvent())),
        BlocProvider(create: (_) => ChangeStudentClassBloc()),
        BlocProvider(create: (_) => GetPaymentBloc()),
        BlocProvider(create: (_) => UniqueAttendanceBloc()),
        BlocProvider(create: (_) => AttendanceCountBloc()),
        BlocProvider(create: (_) => AdmissionBloc()),
        BlocProvider(create: (_) => GetAdmissionBloc()),
        BlocProvider(create: (_) => AdmissionPaymentBloc()),
        BlocProvider(create: (_) => PagesBloc()..add(GetPagesEvent())),
        BlocProvider(create: (_) => PermissionBloc()),
        BlocProvider(create: (_) => UpdateAttendanceBloc()),
        BlocProvider(create: (_) => ClassStudentAttendanceBloc()),
        BlocProvider(create: (_) => AllStudentHasClassBloc()),
        BlocProvider(create: (_) => StudentPercentageBloc()),
        BlocProvider(create: (_) => PaymentMonthlyReportBloc()),
        BlocProvider(create: (_) => TeacherClassCategoryBloc()),
        BlocProvider(create: (_) => StudentInTheClassBloc()),
        BlocProvider(create: (_) => StudentHalfPaymentBloc()),
        BlocProvider(create: (_) => NewAttendanceReadBloc()),
        BlocProvider(create: (_) => TodayClassesBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Aloka',
            theme: lightMode,
            themeMode: state,
            darkTheme: darkMode,
            initialRoute: '/',
            onGenerateRoute: AppRoutes.onGenerateRoute,
          );
        },
      ),
    );
  }
}
