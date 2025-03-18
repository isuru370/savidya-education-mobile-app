import 'dart:developer';

import 'package:aloka_mobile_app/src/modules/payment/components/show_month_selection_dialog.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
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

class PaymentScreen extends StatefulWidget {
  final List<LastPaymentModelClass> studentLastPaymentList;
  final String studentCustomId;

  const PaymentScreen({
    super.key,
    required this.studentLastPaymentList,
    required this.studentCustomId,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int? selectedYear;
  int? selectedMonth;
  late LastPaymentModelClass payStudent;
  String? paymentDate;

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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/print_screen');
              },
              icon: const Icon(Icons.print)),
        ],
      ),
      body: BlocListener<StudentPaymentBloc, StudentPaymentState>(
        listener: (context, state) {
          if (state is StudentPaymentSuccess) {
            Navigator.of(context).pop();
            _showSnackBar(context, 'Payment Successful', Colors.green);
            _printBill(context, payStudent, paymentDate!);
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
        return ShowMonthSelectionDialog(
          selectedYear: selectedYear,
          selectMonth: selectedMonth,
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
      payStudent = student;
      paymentDate = DateFormat('yyyy MMM')
          .format(DateTime(selectedYear!, selectedMonth!));

      final msg = "Dear Parent/Guardian, "
          "payment of LKR:${double.parse(double.parse(student.fees).toStringAsFixed(2)).toStringAsFixed(2)} has been made for ${student.initialName} "
          "at Savidya Edu.\n"
          "- ${student.className}\n"
          "- $paymentDate\n"
          "Thank you for choosing us.";

      final paymentModelClass = PaymentModelClass(
        status: 1,
        amount: double.parse(student.fees),
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
        content: Text(message, maxLines: 2),
        backgroundColor: color,
      ),
    );
  }

  void _printBill(BuildContext context, LastPaymentModelClass payStudent,
      String paymentDate) async {
    BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
    bool isConnected = await bluetooth.isConnected ?? false;

    if (!isConnected) {
      await _connectPrinter(); // Ensure we wait for the connection
      isConnected = await bluetooth.isConnected ?? false;

      if (!isConnected) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Printer not connected!'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }
    }

    bluetooth.printNewLine();
    bluetooth.printCustom("Savidya Edu", 3, 1); // Large, Centered
    bluetooth.printCustom("Payment Receipt", 2, 1);
    bluetooth.printCustom("----------------------", 1, 1); // Separator

    bluetooth.printLeftRight("Student:", payStudent.initialName, 0);
    bluetooth.printLeftRight("Class:", payStudent.className, 1);
    bluetooth.printLeftRight("Category:", payStudent.categoryName, 1);
    bluetooth.printLeftRight("Payment For:", paymentDate, 1);
    bluetooth.printLeftRight("Amount:", "LKR ${payStudent.fees}", 1);

    bluetooth.printNewLine();
    bluetooth.printCustom("Thank you!", 2, 1); // Medium, Centered
    bluetooth.printCustom("----------------------", 1, 1);
    bluetooth.printNewLine();
    bluetooth.paperCut();
  }

  Future<void> _connectPrinter() async {
    BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
    List<BluetoothDevice> devices = await bluetooth.getBondedDevices();

    if (devices.isNotEmpty) {
      await bluetooth
          .connect(devices.first); // Connect to the first paired device
      log("Printer Connected!");
    } else {
      log("No paired devices found.");
    }
  }
}
