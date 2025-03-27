import 'package:aloka_mobile_app/src/modules/tute/bloc/tute_bloc/tute_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'build_tute_count_widget.dart';

class BuildStudentTuteDialog extends StatelessWidget {
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
  final String actionTitle;

  const BuildStudentTuteDialog({
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
    this.actionTitle = 'Pay',
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
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
          BlocBuilder<TuteBloc, TuteState>(
            builder: (context, state) {
              if (state is GetStudentTuteChackSuccessState) {
                return BuildTuteCountWidget(
                  paymentCount: state.paymentCount,
                  tuteCount: state.tuteCount,
                );
              } else if (state is TuteFailureState) {
                return Text(
                  state.failureMessage,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: cancelBtn,
                style: ElevatedButton.styleFrom(
                  iconColor: Colors.red,
                ),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: payBtn,
                style: ElevatedButton.styleFrom(
                  iconColor: Colors.green,
                ),
                child: Text(actionTitle),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
