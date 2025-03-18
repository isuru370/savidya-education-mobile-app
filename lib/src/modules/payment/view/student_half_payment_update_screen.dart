import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../models/payment_model_class/last_payment_model_class.dart';
import '../../../models/payment_model_class/student_half_payment_model.dart';
import '../../../provider/bloc_provider/date_picker_bloc/date_picker_bloc.dart';
import '../../../res/color/app_color.dart';
import '../bloc/student_half_payment/student_half_payment_bloc.dart';
import 'payment_update_dialog.dart';

class StudentHalfPaymentUpdateScreen extends StatefulWidget {
  final List<LastPaymentModelClass> studentLastPaymentList;
  final int studentId;
  final int classHasCatId;
  final String customId;

  const StudentHalfPaymentUpdateScreen({
    super.key,
    required this.studentLastPaymentList,
    required this.studentId,
    required this.classHasCatId,
    required this.customId,
  });

  @override
  State<StudentHalfPaymentUpdateScreen> createState() =>
      _StudentHalfPaymentUpdateScreenState();
}

class _StudentHalfPaymentUpdateScreenState
    extends State<StudentHalfPaymentUpdateScreen> {
  final TextEditingController _selectMonthController = TextEditingController();
  final TextEditingController _classFeesController = TextEditingController();
  int? yearSelect;
  int? monthSelect;

  @override
  void initState() {
    super.initState();

    try {
      // Get the current date
      final DateTime now = DateTime.now();

      // Format it as "yyyy-MMM" (e.g., "2025-Feb")
      final String formattedDate = DateFormat('yyyy-MMM').format(now);

      // Convert to "yyyy-MM" for API request (e.g., "2025-02")
      final String paymentMonth = DateFormat('yyyy-MM').format(now);

      // Dispatch event with formatted date
      context.read<StudentHalfPaymentBloc>().add(
            GetStudentHalfPaymentEvent(
              studentId: widget.studentId,
              classHasCatId: widget.classHasCatId,
              paymentMonth: paymentMonth,
            ),
          );

      // Set the text controller value
      _selectMonthController.text = formattedDate; // ✅ Show "2025-Feb" in UI
    } catch (e) {
      log("Error parsing date: $e");
    }
  }

  @override
  void dispose() {
    _selectMonthController.dispose();
    _classFeesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text('Student Payment Check'),
        backgroundColor: ColorUtil.tealColor[10],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<StudentHalfPaymentBloc, StudentHalfPaymentState>(
            listener: (context, state) {
              if (state is StudentHalfPaymentFailure) {
                _showSnackBar(context, state.failureMessage, Colors.red);
              } else if (state is StudentHalfPaymentUpdateSuccess) {
                _showSnackBar(
                    context, state.halfPaymentUpdateMsg, Colors.green);
              } else if (state is StudentPaymentUpdateSuccess) {
                _showSnackBar(context, state.paymentUpdateMsg, Colors.green);
              } else if (state is StudentHalfPaymentDeleteSuccess) {
                _showSnackBar(
                    context, state.halfPaymentDeleteMsg, Colors.green);
              }
            },
          ),
          BlocListener<DatePickerBloc, DatePickerState>(
            listener: (context, state) {
              if (state is DatePickerFailure) {
                _showSnackBar(context, state.message, Colors.red);
              } else if (state is ClassEndDateSuccessState) {
                _handleDateSelection(state.formatDate);
              }
            },
          ),
        ],
        child: Column(
          children: [
            _buildDatePickerCard(),
            Expanded(
              child:
                  BlocBuilder<StudentHalfPaymentBloc, StudentHalfPaymentState>(
                builder: (context, state) {
                  if (state is StudentHalfPaymentProcess) {
                    return const Center(
                        child: CircularProgressIndicator(strokeWidth: 3.0));
                  } else if (state is StudentHalfPaymentFailure) {
                    return _buildErrorState(state.failureMessage);
                  } else if (state is StudentHalfPaymentSuccess) {
                    return _buildPaymentList(state.studentHalfPaymentModel);
                  } else {
                    return const Center(
                        child: Text('Unexpected state',
                            style: TextStyle(fontSize: 18)));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  void _handleDateSelection(String formatDate) {
    if (_selectMonthController.text != formatDate) {
      _selectMonthController.text = formatDate;
      try {
        final DateTime selectedDate = DateFormat('yyyy-MMM').parse(formatDate);
        final String paymentMonth = DateFormat('yyyy-MM').format(selectedDate);
        context.read<StudentHalfPaymentBloc>().add(
              GetStudentHalfPaymentEvent(
                studentId: widget.studentId,
                classHasCatId: widget.classHasCatId,
                paymentMonth: paymentMonth,
              ),
            );
      } catch (e) {
        log("Error parsing date: $e");
      }
    }
  }

  Widget _buildDatePickerCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        child: ListTile(
          leading: const Icon(Icons.date_range, color: Colors.teal),
          title: TextFormField(
            controller: _selectMonthController,
            decoration: const InputDecoration(
              hintText: 'Select Month',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(8),
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.calendar_today, color: Colors.teal),
            onPressed: () {
              context
                  .read<DatePickerBloc>()
                  .add(ClassEndDatePicker(context: context));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error, color: Colors.red, size: 40),
          SizedBox(height: 8),
          Text(
            "Not paid for the current month.",
            style: TextStyle(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentList(List<StudentHalfPaymentModel> payments) {
    if (payments.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.no_accounts, size: 40),
            SizedBox(height: 8),
            Text('No data found', style: TextStyle(fontSize: 18)),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: payments.length,
      itemBuilder: (context, index) {
        return _buildPaymentCard(payments[index]);
      },
    );
  }

  Widget _buildPaymentCard(StudentHalfPaymentModel payment) {
    final currencyFormatter = NumberFormat.currency(
        locale: 'en_LK', symbol: 'LKR ', decimalDigits: 2);

    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          color: ColorUtil.blackColor[16],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                payment.paymentFor ?? "No Description",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fees: ${currencyFormatter.format(payment.fees ?? 0.0)}',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Amount: ${currencyFormatter.format(payment.amount ?? 0.0)}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Text(
                    'Attendance Count: ${payment.attendanceCount ?? 0}',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
            Text(
              payment.paymentStatus == 0 ? 'Payment Deleted' : "Active Payment",
              style: TextStyle(
                color: payment.paymentStatus == 0 ? Colors.red : Colors.green,
                fontSize: 16,
              ),
            ),
            const Divider(height: 1, color: Colors.white),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    icon: Icons.payment,
                    label: "Update",
                    color: Colors.teal,
                    onPressed: () => _handleUpdatePayment(payment),
                  ),
                  _buildActionButton(
                    icon: Icons.delete,
                    label: "Delete Payment",
                    color: Colors.redAccent,
                    onPressed: () => _handleDeletePayment(payment),
                  ),
                  _buildActionButton(
                    icon: Icons.update,
                    label: "Half Payment",
                    color: Colors.orange,
                    onPressed: () => _handleHalfPayment(payment),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Flexible(
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(label, overflow: TextOverflow.ellipsis),
        style: ElevatedButton.styleFrom(backgroundColor: color),
      ),
    );
  }

  void _handleUpdatePayment(StudentHalfPaymentModel payment) {
    if (payment.amount != null && payment.paymentStatus != 0) {
      showDialog(
        context: context,
        builder: (context) => PaymentUpdateDialog(
          classFeesController: _classFeesController,
          fees: payment.fees ?? 0.00,
          amount: payment.amount ?? 0.00,
          studentLastPaymentList: widget.studentLastPaymentList,
          cancel: () => Navigator.of(context).pop(),
          update: (int selectedYear, int selectedMonth, int studentClassId,
              double updatedFees) {
            if (_classFeesController.text.trim().isNotEmpty &&
                (payment.paymentStatus ?? 0) != 0) {
              double? newAmount =
                  double.tryParse(_classFeesController.text.trim());

              if (newAmount == null || newAmount <= 0) {
                _showSnackBar(
                    context, "Please enter a valid amount.", Colors.red);
                return;
              }

              // ✅ Convert numeric month to short month name using DateFormat
              String monthName =
                  DateFormat('MMM').format(DateTime(2000, selectedMonth));

              // ✅ Correct format: "2025 Jan"
              String formattedPaymentFor = "$selectedYear $monthName";

              StudentHalfPaymentModel halfPaymentModel =
                  StudentHalfPaymentModel(
                paymentId: payment.paymentId,
                paymentFor: formattedPaymentFor,
                amount: newAmount,
                studentStudentClassId: studentClassId,
              );

              final msg = _sendUpdateToMG(
                payment.className.toString(),
                payment.categoryName.toString(),
                "update",
              );

              // 🔹 Dispatch update event (Uncomment when integrating with BLoC)
              context.read<StudentHalfPaymentBloc>().add(
                    UpdateStudentPaymentEvent(
                      studentHalfPaymentModel: halfPaymentModel,
                      msg: msg,
                    ),
                  );

              // ✅ Close the dialog after a successful update
              Navigator.of(context).pop();
            } else {
              _showSnackBar(context, "Invalid payment status or empty amount.",
                  Colors.red);
            }
          },
        ),
      );
    }
  }

  void _handleDeletePayment(StudentHalfPaymentModel payment) {
    if (payment.paymentStatus != 0) {
      showDeleteConfirmationDialog(
        context: context,
        onConfirm: () {
          final msg = _sendUpdateToMG(
            payment.className.toString(),
            payment.categoryName.toString(),
            "delete",
          );
          context.read<StudentHalfPaymentBloc>().add(
                StudentPaymentDeleteEvent(
                    paymentId: payment.paymentId!, msg: msg),
              );
        },
      );
    }
  }

  void _handleHalfPayment(StudentHalfPaymentModel payment) {
    if (payment.attendanceCount == 1 &&
        payment.amount != null &&
        payment.fees == payment.amount) {
      final double halfPay = payment.amount! / 2;

      StudentHalfPaymentModel halfPaymentModel = StudentHalfPaymentModel(
        paymentId: payment.paymentId,
        paymentFor: payment.paymentFor,
        amount: halfPay,
        fees: payment.fees,
        attendanceCount: payment.attendanceCount,
      );

      final msg = _sendUpdateToMG(
        payment.className.toString(),
        payment.categoryName.toString(),
        "half payment update",
      );

      context.read<StudentHalfPaymentBloc>().add(
            UpdateStudentHalfPaymentEvent(
              studentHalfPaymentModel: halfPaymentModel,
              msg: msg,
            ),
          );
    } else {
      _showSnackBar(
          context, "Half payment update failed: Invalid data.", Colors.red);
    }
  }

  void showDeleteConfirmationDialog({
    required BuildContext context,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirm Deletion",
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text(
            "Are you sure you want to delete this payment? This action cannot be undone.",
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel",
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child:
                  const Text("Confirm", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  String _sendUpdateToMG(String className, String categoryName, String name) {
    final currentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    return "Payment for ${widget.customId}'s $className $categoryName $name on $currentDate";
  }
}
