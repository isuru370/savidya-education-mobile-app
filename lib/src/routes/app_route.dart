import 'package:aloka_mobile_app/src/modules/admission_screen/view/add_admission_screen.dart';
import 'package:aloka_mobile_app/src/modules/admission_screen/view/add_student_admission.dart';
import 'package:aloka_mobile_app/src/modules/admission_screen/view/today_admission_screen.dart';
import 'package:aloka_mobile_app/src/modules/attendance/view/attendance_mark_screen.dart';
import 'package:aloka_mobile_app/src/modules/attendance/view/new_attendance_mark_screen.dart';
import 'package:aloka_mobile_app/src/modules/attendance/view/student_unique_attendance.dart';
import 'package:aloka_mobile_app/src/modules/auth_screen/view/password_change.dart';
import 'package:aloka_mobile_app/src/modules/auth_screen/view/password_reset_screen.dart';
import 'package:aloka_mobile_app/src/modules/auth_screen/view/user_profile_screen.dart';
import 'package:aloka_mobile_app/src/modules/auth_screen/view/user_screen.dart';
import 'package:aloka_mobile_app/src/modules/camera_screen/view/quick_camera_screen.dart';
import 'package:aloka_mobile_app/src/modules/camera_screen/view/search_quick_image.dart';
import 'package:aloka_mobile_app/src/modules/class_screen/arguments/select_class_arguments.dart';
import 'package:aloka_mobile_app/src/modules/class_screen/view/all_class_screen.dart';
import 'package:aloka_mobile_app/src/modules/class_screen/view/class_category.dart';
import 'package:aloka_mobile_app/src/modules/class_screen/view/class_schedule_attendance.dart';
import 'package:aloka_mobile_app/src/modules/class_screen/view/class_view_screen.dart';
import 'package:aloka_mobile_app/src/modules/class_screen/view/class_screen.dart';
import 'package:aloka_mobile_app/src/modules/class_screen/view/class_start_screen.dart';
import 'package:aloka_mobile_app/src/modules/class_screen/view/re_schedule_screen.dart';
import 'package:aloka_mobile_app/src/modules/class_screen/view/schedule_screen.dart';
import 'package:aloka_mobile_app/src/modules/class_screen/view/schedule_view_screen.dart';
import 'package:aloka_mobile_app/src/modules/class_screen/view/select_class_view_screen.dart';
import 'package:aloka_mobile_app/src/modules/class_screen/view/single_class_view_screen.dart';
import 'package:aloka_mobile_app/src/modules/home_screen/arguments/student_editable.dart';
import 'package:aloka_mobile_app/src/modules/home_screen/view/home_page.dart';
import 'package:aloka_mobile_app/src/modules/home_screen/view/today_class_screen.dart';
import 'package:aloka_mobile_app/src/modules/payment/view/payment_check.dart';
import 'package:aloka_mobile_app/src/modules/payment/view/payment_screen.dart';
import 'package:aloka_mobile_app/src/modules/payment/view/view_student_unique_payment.dart';
import 'package:aloka_mobile_app/src/modules/qr_code_screen/view/new_attendance_read.dart';
import 'package:aloka_mobile_app/src/modules/qr_code_screen/view/qr_student_id_fetcher.dart';
import 'package:aloka_mobile_app/src/modules/qr_code_screen/view/read_payment.dart';
import 'package:aloka_mobile_app/src/modules/qr_code_screen/view/read_screen.dart';
import 'package:aloka_mobile_app/src/modules/qr_code_screen/view/student_id_generate.dart';
import 'package:aloka_mobile_app/src/modules/settings_screen/view/help_center_screen.dart';
import 'package:aloka_mobile_app/src/modules/student_screen/view/all_student_screen.dart';
import 'package:aloka_mobile_app/src/modules/student_screen/view/generate_student_id.dart';
import 'package:aloka_mobile_app/src/modules/student_screen/view/student_add_class.dart';
import 'package:aloka_mobile_app/src/modules/student_screen/view/student_screen.dart';
import 'package:aloka_mobile_app/src/modules/student_screen/view/view_student_class_details.dart';
import 'package:aloka_mobile_app/src/modules/teacher_screen/view/teacher_all_screen.dart';
import 'package:aloka_mobile_app/src/modules/teacher_screen/view/teacher_class_category.dart';
import 'package:aloka_mobile_app/src/modules/teacher_screen/view/teacher_has_student_report.dart';
import 'package:aloka_mobile_app/src/modules/teacher_screen/view/teacher_screen.dart';
import 'package:aloka_mobile_app/src/modules/teacher_screen/view/teacher_view_screen.dart';
import 'package:flutter/material.dart';

import '../modules/auth_screen/view/login_page.dart';
import '../modules/class_screen/view/class_student_attendance.dart';
import '../modules/home_screen/arguments/from_data.dart';
import '../modules/payment/view/payment_monthly_report_screen.dart';
import '../modules/payment/view/student_half_payment_screen.dart';
import '../modules/payment/view/student_half_payment_update_screen.dart';
import '../modules/reports/view/print_screen.dart';
import '../modules/reports/view/report_screen.dart';
import '../modules/student_screen/view/student_view_screen.dart';
import '../modules/teacher_screen/view/teacher_paid_not_paid_report.dart';
import '../modules/unknown_page/view/unknown_page.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case '/password_reset':
        return MaterialPageRoute(
          builder: (context) => const PasswordResetScreen(),
        );
      case '/password_change_screen':
        final userData = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ChangePasswordScreen(
            userName: userData['userName'],
          ),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case '/quick_camera':
        final fromData = setting.arguments as FromData;
        return MaterialPageRoute(
          builder: (context) => QuickCameraScreen(
            studentImageUrl: fromData.studentImagePath,
          ),
        );
      case '/read_student_id_screen':
        final navigateScreen = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => QRStudentIdFetcher(
            screenName: navigateScreen['screen_name'],
          ),
        );
      case '/student':
        final studentEditable = setting.arguments as StudentEditable;
        return MaterialPageRoute(
          builder: (context) => StudentScreen(
            studentModelClass: studentEditable.editable
                ? studentEditable.studentModelClass
                : null,
            editMode: studentEditable.editable,
          ),
        );
      case '/search_quick_image':
        return MaterialPageRoute(
          builder: (context) => const SearchQuickImage(),
        );
      case '/add_student_class':
        final studentIdData = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => StudentAddClass(
            studentId: studentIdData['student_id'],
            cusStudentId: studentIdData['student_custom_id'],
            studentInitialName: studentIdData['student_initial_name'],
            isBottomNavBar: studentIdData['is_bottom_nav_bar'],
          ),
        );
      case '/view_student_details':
        final studentIdData = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ViewStudentClassDetails(
            studentId: studentIdData['student_id'],
            customId: studentIdData['custom_id'],
            initialName: studentIdData['initial_name'],
          ),
        );
      case '/class_at_category':
        final argumentsClassId = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ClassCategory(
            classId: argumentsClassId['class_id'],
          ),
        );
      case '/user_profile':
        return MaterialPageRoute(
          builder: (context) => const UserProfileScreen(),
        );
      case '/all_active_student':
        final studentViewEditable =
            setting.arguments as ActiveStudentViewEditable;
        return MaterialPageRoute(
          builder: (context) => AllStudentScreen(
            studentEditable: studentViewEditable.editable,
          ),
        );
      case '/view_student':
        final studentViewData = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => StudentViewScreen(
            studentModel: studentViewData['student_model_class'],
          ),
        );
      case '/generate_id':
        final studentIdData = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => StudentIdGenerate(
            studentId: studentIdData['student_id'],
            cusStudentId: studentIdData['cus_student_id'],
            studentInitialName: studentIdData['student_initial_name'],
          ),
        );
      case '/student_generate_id':
        return MaterialPageRoute(
          builder: (context) => const GenerateStudentId(),
        );
      case '/teacher_screen':
        final teacherEditable = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => TeacherScreen(
            teacherModelClass: teacherEditable['update_teacher'] == true
                ? teacherEditable['teacher_data']
                : null,
            editMode: teacherEditable['update_teacher'],
          ),
        );
      case '/teacher_all_screen':
        final teacherEditable = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => TeacherAllScreen(
            editMode: teacherEditable['update_teacher'],
          ),
        );
      case '/teacher_profile_screen':
        final teacherEditable = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => TeacherViewScreen(
            teacherModelClass: teacherEditable['teacher_data'],
          ),
        );
      case '/teacher_has_category_screen':
        final teacher = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => TeacherClassCategory(
            teacherClassId: teacher['teacher_class_id'],
            gradeName: teacher['grade_name'],
            teacherName: teacher['teacher_name'],
            className: teacher['class_name'],
          ),
        );
      case '/teacher_student_report_screen':
        final teacher = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => TeacherHasStudentReport(
            classId: teacher['class_id'],
            classHasCatId: teacher['class_has_cat_id'],
            gradeName: teacher['grade_name'],
            teacherName: teacher['teacher_name'],
            className: teacher['class_name'],
          ),
        );

      case '/class_screen':
        final classEditable = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ClassScreen(
              classScheduleModelClass: classEditable['edit_mode']
                  ? classEditable['class_schedule_model_class']
                  : null,
              editMode: classEditable['edit_mode']),
        );
      case '/all_active_class':
        final classEditable = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) =>
              AllClassScreen(classEditable: classEditable['edit_mode']),
        );
      case '/view_class':
        final classDetails = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => SingleClassViewScreen(
              classScheduleModelClass: classDetails['class_details']),
        );
      case '/class_schedule':
        return MaterialPageRoute(
          builder: (context) => const ClassScheduleScreen(),
        );
      case '/schedule_view':
        final classData = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ScheduleViewScreen(
            classId: classData['class_id'],
          ),
        );
      case '/schedule_screen':
        final classCat = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ScheduleScreen(
            classCatId: classCat['classCatId'],
          ),
        );
      case '/re_schedule_screen':
        final classAttList = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ReScheduleScreen(
            classAttendanceModelClass: classAttList['class_attendance_list'],
            scheduleText: classAttList['schedule_text'],
          ),
        );
      case '/select_class':
        final classEvent = setting.arguments as SelectClassArguments;
        return MaterialPageRoute(
          builder: (context) => SelectClassViewScreen(
            classPayHasAtt: classEvent.selectPayHasAtt!,
          ),
        );
      case '/class_start_screen':
        final classStatus = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ClassStartScreen(
            classCatId: classStatus['classHasCatId'],
            classId: classStatus['classId'],
          ),
        );
      case '/class_schedule_attendance_screen':
        final classStatus = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ClassScheduleAttendance(
            classCatId: classStatus['classHasCatId'],
            classId: classStatus['classId'],
          ),
        );
      case '/today_classes':
        return MaterialPageRoute(
          builder: (context) => const TodayClassScreen(),
        );
      case '/class_student_attendance':
        final classStatus = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ClassStudentAttendance(
            className: classStatus['class_name'],
            gradeName: classStatus['grade_name'],
            categoryName: classStatus['category_name'],
            classCatId: classStatus['class_cat_id'],
            classDate: classStatus['class_date'],
          ),
        );
      case '/new_attendance_read_screen':
        return MaterialPageRoute(
          builder: (context) => const NewAttendanceRead(),
        );
      case '/qr_code_read':
        final classIdEvent = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => QRCodeReadScreen(
            classHasId: classIdEvent['classCatId'],
            classAttendanceId: classIdEvent['attendanceId'],
          ),
        );
      case '/attendance_mark':
        final readStudentData = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => AttendanceMarkScreen(
            studentList: readStudentData['read_student_data'],
            classAttList: readStudentData['read_class_data'],
            paymentList: readStudentData['read_payment_data'],
            attendanceId: readStudentData['attendance_id'],
            studentCusId: readStudentData['student_cus_id'],
          ),
        );
      case '/new_attendance_mark':
        final readStudentData = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => NewAttendanceMarkScreen(
            newAttendanceReadModel: readStudentData['read_student_data'],
          ),
        );
      case '/unique_attendance':
        final attendanceStudentData = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => StudentUniqueAttendance(
            studentId: attendanceStudentData['studentId'],
            classCategoryHasStudentClassId:
                attendanceStudentData['class_category_has_student_class_id'],
            studentHasClassId: attendanceStudentData['student_has_class_id'],
          ),
        );
      case '/payment_read_screen':
        final readData = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => QRCodeReadPaymentScreen(
            title: readData['name'],
          ),
        );
      case '/payment_screen':
        final readStudentData = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => PaymentScreen(
            studentLastPaymentList: readStudentData['student_last_payment'],
            studentCustomId: readStudentData['student_custom_id'],
          ),
        );
      case '/al_payment_screen':
        final readStudentData = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => PaymentCheck(
            studentLastPaymentList: readStudentData['student_last_payment'],
            studentCustomId: readStudentData['student_custom_id'],
          ),
        );
      case '/half_payment_screen':
        final readStudentData = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => StudentHalfPaymentScreen(
            studentLastPaymentList: readStudentData['student_last_payment'],
            studentCustomId: readStudentData['student_custom_id'],
          ),
        );
      case '/student_half_payment_update_screen':
        final readStudentData = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => StudentHalfPaymentUpdateScreen(
            studentId: readStudentData['student_id'],
            classHasCatId: readStudentData['class_has_cat_id'],
            customId: readStudentData["custom_id"],
            studentLastPaymentList: readStudentData["class_details"],
          ),
        );
      case '/view_student_unique_payment':
        final studentData = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ViewStudentUniquePayment(
            studentId: studentData['student_id'],
            classCategoryHasStudentClassId:
                studentData['class_category_has_student_class_id'],
          ),
        );
      case '/payment_monthly_report_screen':
        final studentData = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => PaymentMonthlyReportScreen(
            classHasCatId: studentData['class_category_has_student_class_id'],
            gradeName: studentData['garde_name'],
            className: studentData['class_name'],
            categoryName: studentData['category_name'],
          ),
        );
      case '/payment_monthly_paid_not_paid_report_screen':
        final studentData = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => TeacherPaidNotPaidReport(
            classHasCatId: studentData['class_category_has_student_class_id'],
            gradeName: studentData['garde_name'],
            className: studentData['class_name'],
            categoryName: studentData['category_name'],
          ),
        );
      case '/user_screen':
        return MaterialPageRoute(
          builder: (context) => const UserScreen(),
        );
      case '/add_admission':
        return MaterialPageRoute(
          builder: (context) => const AddAdmissionScreen(),
        );
      case '/pay_admission':
        return MaterialPageRoute(
          builder: (context) => const AddStudentAdmission(),
        );
      case '/today_pay_admission':
        return MaterialPageRoute(
          builder: (context) => const TodayAdmissionScreen(),
        );
      case '/reports':
        return MaterialPageRoute(
          builder: (context) => const ReportScreen(),
        );
        case '/print_screen':
        return MaterialPageRoute(
          builder: (context) => const PrintScreen(),
        );
      case '/help_screen':
        return MaterialPageRoute(
          builder: (context) => const HelpCenterScreen(),
        );
      case '/unknown_page':
        return MaterialPageRoute(
          builder: (context) => const UnknownPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
    }
  }
}
