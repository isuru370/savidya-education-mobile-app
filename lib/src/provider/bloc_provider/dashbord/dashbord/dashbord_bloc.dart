import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/dashbord/dashbord_services.dart';

part 'dashbord_event.dart';
part 'dashbord_state.dart';

class DashbordBloc extends Bloc<DashbordEvent, DashbordState> {
  DashbordBloc() : super(DashbordInitial()) {
    on<GetReport>((event, emit) async {
      emit(DashbordProcess());
      try {
        await getReport().then(
          (count) {
            if (count['success']) {
              // Check if the value is a String, if so, parse it
              int activeStuCount = (count['active_stu_count'] is String)
                  ? int.parse(count['active_stu_count'])
                  : count['active_stu_count'];

              int inactiveStuCount = (count['inactive_stu_count'] is String)
                  ? int.parse(count['inactive_stu_count'])
                  : count['inactive_stu_count'];

              int activeTeaCount = (count['active_tea_count'] is String)
                  ? int.parse(count['active_tea_count'])
                  : count['active_tea_count'];

              int inactiveTeaCount = (count['inactive_tea_count'] is String)
                  ? int.parse(count['inactive_tea_count'])
                  : count['inactive_tea_count'];

              int activeClassCount = (count['active_class_count'] is String)
                  ? int.parse(count['active_class_count'])
                  : count['active_class_count'];

              int inactiveClassCount = (count['inactive_class_count'] is String)
                  ? int.parse(count['inactive_class_count'])
                  : count['inactive_class_count'];

              int deleteClassCount = (count['delete_class_count'] is String)
                  ? int.parse(count['delete_class_count'])
                  : count['delete_class_count'];

              // Emit the student report with the correct values
              emit(DashbordReport(
                activeStudentCount: activeStuCount,
                inactiveStudentCount: inactiveStuCount,
                activeTeacherCount: activeTeaCount,
                inactiveTeacherCount: inactiveTeaCount,
                activeClassCount: activeClassCount,
                inactiveClassCount: inactiveClassCount,
                deleteClassCount: deleteClassCount,
              ));
            } else {
              emit(DashbordFailure(errorMSG: count['message']));
            }
          },
        );
      } catch (e) {
        log(e.toString());
        emit(const DashbordFailure(errorMSG: "data not found"));
      }
    });
    on<GetPaymentReport>((event, emit) async {
      emit(DashbordProcess());
      try {
        await getPaymentReport().then(
          (paymentReport) {
            if (paymentReport['success']) {
              double parseToDouble(dynamic value) {
                if (value is int) return value.toDouble();
                if (value is String) return double.tryParse(value) ?? 0.0;
                if (value is double) return value;
                return 0.0; // Default fallback
              }

              double dallyAmount =
                  parseToDouble(paymentReport['daily_payment_tot']);
              double monthllyAmount =
                  parseToDouble(paymentReport['monthly_payment_tot']);
              double yearllyAmount =
                  parseToDouble(paymentReport['yearly_payment_tot']);

              emit(DashbordPaymentReport(
                dallyAmont: dallyAmount,
                monthlyAmount: monthllyAmount,
                yearllyAmount: yearllyAmount,
              ));
            } else {
              emit(DashbordFailure(errorMSG: paymentReport['message']));
            }
          },
        );
      } catch (e) {
        log(e.toString());
        emit(const DashbordFailure(errorMSG: "data not found"));
      }
    });

    on<GetPaymentChartReport>((event, emit) async {
      emit(DashbordProcess());
      try {
        await getPaymentReport().then(
          (paymentChartReport) {
            if (paymentChartReport['success']) {
              emit(DashbordPaymentChartReport(
                  dallyAmont: paymentChartReport['daily_payment_tot'],
                  monthlyAmount: paymentChartReport['monthly_payment_tot'],
                  yearllyAmount: paymentChartReport['yearly_payment_tot']));
            } else {
              emit(DashbordFailure(errorMSG: paymentChartReport['message']));
            }
          },
        );
      } catch (e) {
        emit(const DashbordFailure(errorMSG: "data not found"));
      }
    });
  }
}
