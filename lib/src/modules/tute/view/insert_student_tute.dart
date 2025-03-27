import 'package:aloka_mobile_app/src/modules/tute/bloc/tute_bloc/tute_bloc.dart';
import 'package:aloka_mobile_app/src/res/color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../models/payment_model_class/last_payment_model_class.dart';
import '../../payment/components/build_student_info_widget.dart';
import '../../student_screen/bloc/student_in_the_class/student_in_the_class_bloc.dart';
import '../component/build_student_tute_List_Item.dart';
import '../component/build_student_tute_dialog.dart';

class InsertStyudentTute extends StatefulWidget {
  final int studentId;
  final String cusStudentId;
  final String? studentInitialName;
  const InsertStyudentTute({
    super.key,
    required this.studentId,
    required this.cusStudentId,
    required this.studentInitialName,
  });

  @override
  State<InsertStyudentTute> createState() => _InsertStyudentTuteState();
}

class _InsertStyudentTuteState extends State<InsertStyudentTute> {
  int? selectedYear;
  int? selectedMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedYear = now.year;
    selectedMonth = now.month;

    context
        .read<StudentInTheClassBloc>()
        .add(GetStudentAllClassEvent(studentId: widget.studentId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tute'),
        backgroundColor: ColorUtil.tealColor[10],
      ),
      body: BlocListener<TuteBloc, TuteState>(
        listener: (context, state) {
          if (state is InsertTuteSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage),
                backgroundColor: ColorUtil.tealColor[10],
              ),
            );
            Navigator.pop(context);
          } else if (state is TuteFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failureMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<StudentInTheClassBloc, StudentInTheClassState>(
          builder: (context, state) {
            if (state is StudentInTheClassProcess) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UnicStudentAllClass) {
              final studentClassList = state.studentInTheClassModel;

              return Column(
                children: [
                  _buildStudentInfo(studentClassList[0]),
                  Expanded(
                      child: _buildStudentList(state.studentInTheClassModel)),
                ],
              );
            }
            return const Center(
              child: Text(
                "No data found",
                style: TextStyle(fontSize: 20),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStudentInfo(LastPaymentModelClass student) {
    return BuildStudentInfoWidget(
      imageUrl: student.imageUrl,
      initialName: student.initialName,
      studentCustomId: widget.cusStudentId,
    );
  }

  Widget _buildStudentList(List<LastPaymentModelClass> classes) {
    return ListView.builder(
      itemCount: classes.length,
      itemBuilder: (context, index) {
        final students = classes[index];
        return _buildStudentListItem(students);
      },
    );
  }

  Widget _buildStudentListItem(LastPaymentModelClass student) {
    return BuildStudentTuteListItem(
      className: student.className,
      categoryName: student.categoryName,
      gradeName: student.gradeName,
      studentFreeCard: student.classFreeCard,
      onPayPressed: () {
        _showMonthSelectionDialog(context, student);
      },
    );
  }

  void _showMonthSelectionDialog(
      BuildContext context, LastPaymentModelClass student) {
    final currentYear = DateTime.now().year;

    final years = List.generate(5, (index) => currentYear - index);
    final months = List.generate(12, (index) => index + 1);

    final yearItems = years
        .map((year) => DropdownMenuItem<int>(
              value: year,
              child: Text('$year'),
            ))
        .toList();

    final monthItems = months
        .map((month) => DropdownMenuItem<int>(
              value: month,
              child: Text(DateFormat('MMM').format(DateTime(0, month))),
            ))
        .toList();

    showDialog(
      context: context,
      builder: (context) {
        return BuildStudentTuteDialog(
          selectedYear: selectedYear,
          selectMonth: selectedMonth,
          yearItems: yearItems,
          monthItems: monthItems,
          actionTitle: 'Save',
          yearChanged: (value) {
            if (value != null) {
              setState(() => selectedYear = value);
            }
          },
          monthChanged: (value) {
            if (value != null) {
              _updateSelectedMonth(value, context, student);
            }
          },
          cancelBtn: () => Navigator.pop(context),
          payBtn: () => _processTute(context, student),
        );
      },
    );
  }

  void _updateSelectedMonth(
      int value, BuildContext context, LastPaymentModelClass student) {
    setState(() {
      selectedMonth = value;
    });
    _dispatchAttendanceEvent(context, student);
  }

  void _dispatchAttendanceEvent(
      BuildContext context, LastPaymentModelClass student) {
    final formattedDate =
        DateFormat('yyyy MMM').format(DateTime(selectedYear!, selectedMonth!));

    // print(
    //     'formattedDate: $formattedDate studentId: ${widget.studentId} studentStudentClassId: ${student.studentStudentClassId} classCategoryId: ${student.classHasCategory}');
    context.read<TuteBloc>().add(CheckStudentTuteCountEvent(
          tuteFor: formattedDate,
          studentId: widget.studentId,
          studentStudentClassId:
              int.parse(student.studentStudentClassId.toString()),
          classCategoryId: int.parse(student.classHasCategory.toString()),
        ));
  }

  void _processTute(BuildContext context, LastPaymentModelClass student) {
    final paymentDate =
        DateFormat('yyyy MMM').format(DateTime(selectedYear!, selectedMonth!));

    context.read<TuteBloc>().add(
          InsertTuteEvent(
            studentId: widget.studentId,
            classCategoryId: int.parse(student.classHasCategory.toString()),
            tuteFor: paymentDate,
          ),
        );
  }
}
