import 'package:aloka_mobile_app/src/modules/payment/components/show_month_selection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../models/payment_model_class/last_payment_model_class.dart';
import '../../../models/payment_model_class/payment_model_class.dart';
import '../../attendance/bloc/attendance_count/attendance_count_bloc.dart';
import '../bloc/student_payment/student_payment_bloc.dart';
import '../bloc/student_payment/student_payment_state.dart';
import '../components/build_student_info_widget.dart';
import '../components/build_student_list_item_widget.dart';

class PaymentCheck extends StatefulWidget {
  final List<LastPaymentModelClass> studentLastPaymentList;
  final String studentCustomId;

  const PaymentCheck({
    super.key,
    required this.studentLastPaymentList,
    required this.studentCustomId,
  });

  @override
  State<PaymentCheck> createState() => _PaymentCheckState();
}

class _PaymentCheckState extends State<PaymentCheck> {
  final TextEditingController _classFees = TextEditingController();
  int? selectedYear;
  int? selectedMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedYear = now.year;
    selectedMonth = now.month;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Screen'),
        backgroundColor: Colors.teal,
      ),
      body: BlocListener<StudentPaymentBloc, StudentPaymentState>(
        listener: (context, state) {
          if (state is StudentPaymentSuccess) {
            Navigator.of(context).pop();
            _showSnackBar(context, 'Payment Successful', Colors.green);
          } else if (state is StudentPaymentFailure) {
            Navigator.of(context).pop();
            _showSnackBar(
                context, 'Payment Failed: ${state.failureMessage}', Colors.red);
          }
        },
        child: Column(
          children: [
            _buildStudentInfo(),
            const SizedBox(height: 16),
            Expanded(child: _buildStudentList()),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentInfo() {
    final student = widget.studentLastPaymentList.isNotEmpty
        ? widget.studentLastPaymentList[0]
        : null;

    return BuildStudentInfoWidget(
      imageUrl: student?.imageUrl ?? '',
      initialName: student?.initialName ?? 'No Name Available',
      studentCustomId: widget.studentCustomId,
    );
  }

  Widget _buildStudentList() {
    return ListView.builder(
      itemCount: widget.studentLastPaymentList.length,
      itemBuilder: (context, index) {
        final student = widget.studentLastPaymentList[index];
        return _buildStudentListItem(student);
      },
    );
  }

  Widget _buildStudentListItem(LastPaymentModelClass student) {
    return BuildStudentListItemWidget(
      className: student.className,
      categoryName: student.categoryName,
      gradeName: student.gradeName,
      lastPaymentDate: student.lastPaymentDate,
      lastPaymentFor: student.lastPaymentFor,
      studentFreeCard: student.classFreeCard,
      onPayPressed: () {
        _showMonthSelectionDialog(
            context, student); // Replace `student` with actual data.
      },
    );
  }

  void _showMonthSelectionDialog(
      BuildContext context, LastPaymentModelClass student) {
    final currentYear = DateTime.now().year;

    // Generate the list of years and months.
    final years = List.generate(5, (index) => currentYear - index);
    final months = List.generate(12, (index) => index + 1);
    final formattedDate = DateFormat('yyyy-MM-dd')
        .format(DateTime(selectedYear!, selectedMonth!));
    context.read<AttendanceCountBloc>().add(
          CountAttendanceEvent(
            date: formattedDate,
            studentId: int.parse(student.studentId),
            studentStudentClassId: int.parse(student.studentStudentClassId),
          ),
        );
    // Convert years and months into DropdownMenuItem lists.
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
        return ShowMonthSelectionDialog(
          selectedYear: selectedYear, // Already initialized elsewhere.
          selectMonth: selectedMonth, // Already initialized elsewhere.
          yearItems: yearItems,
          monthItems: monthItems,
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
          widget: TextField(
            controller: _classFees,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Class Fees',
              hintText: 'Enter class fees',
              prefixIcon: const Icon(Icons.money),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
          cancelBtn: () => Navigator.pop(context),
          payBtn: () => _processPayment(context, student),
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
    final formattedDate = DateFormat('yyyy-MM-dd')
        .format(DateTime(selectedYear!, selectedMonth!));
    context.read<AttendanceCountBloc>().add(
          CountAttendanceEvent(
            date: formattedDate,
            studentId: int.parse(student.studentId),
            studentStudentClassId: int.parse(student.studentStudentClassId),
          ),
        );
  }

  void _processPayment(BuildContext context, LastPaymentModelClass student) {
    if (selectedYear != null && selectedMonth != null) {
      final paymentDate = DateFormat('yyyy MMM')
          .format(DateTime(selectedYear!, selectedMonth!));

      final msg = "Dear Parent/Guardian, "
          "payment of \$${double.parse(_classFees.text.trim()).toStringAsFixed(2)} has been made for ${student.initialName} "
          "at Savidya Higher Education Institute.\n"
          "- Class: ${student.className}\n"
          "- Category: ${student.categoryName}\n"
          "- Type: ${student.lastPaymentFor}\n"
          "Thank you for choosing us.";

      final paymentModelClass = PaymentModelClass(
        status: 1,
        amount: double.parse(_classFees.text.trim()),
        paymentFor: paymentDate,
        studentId: int.parse(student.studentId),
        studentStudentStudentClassesId:
            int.parse(student.studentStudentClassId),
      );

      context.read<StudentPaymentBloc>().add(
            InsertStudentPaymentEvent(
              paymentModelClass: paymentModelClass,
              msg: msg,
              number: student.guardianMobile,
            ),
          );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Processing payment for $paymentDate...'),
          backgroundColor: Colors.blue,
        ),
      );

      // Trigger payment event here using the Bloc.
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select month and year'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
            message,
            maxLines: 2,
          ),
          backgroundColor: color),
    );
  }
}
