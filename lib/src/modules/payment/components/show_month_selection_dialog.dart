import 'package:aloka_mobile_app/src/modules/attendance/bloc/attendance_count/attendance_count_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'attendance_count_widget.dart';

class ShowMonthSelectionDialog extends StatelessWidget {
  final int? selectedYear;
  final int? selectMonth;
  final String? attendanceCount;
  final Widget? widget;
  final List<DropdownMenuItem<int>>? yearItems;
  final List<DropdownMenuItem<int>>? monthItems;
  final Function(int?)? yearChanged;
  final Function(int?)? monthChanged;
  final VoidCallback? cancelBtn;
  final VoidCallback? payBtn;

  const ShowMonthSelectionDialog({
    super.key,
    this.selectedYear,
    this.selectMonth,
    this.attendanceCount,
    this.widget,
    this.yearItems,
    this.monthItems,
    this.yearChanged,
    this.monthChanged,
    this.cancelBtn,
    this.payBtn,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Month and Year'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<int>(
            value: selectedYear,
            items: yearItems,
            onChanged: yearChanged,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<int>(
            value: selectMonth,
            items: monthItems,
            onChanged: monthChanged,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          widget ?? const SizedBox.shrink(),
          BlocBuilder<AttendanceCountBloc, AttendanceCountState>(
            builder: (context, state) {
              if (state is AttendanceCountSuccess) {
                return AttendanceCountWidget(
                    attendanceCount: state.attendanceCount.toString());
              } else if (state is AttendanceCountFailure) {
                return const Text(
                  'f',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                );
              } else {
                return const SizedBox();
              }
            },
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: cancelBtn,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: payBtn,
          child: const Text('Confirm Payment'),
        ),
      ],
    );
  }
}
