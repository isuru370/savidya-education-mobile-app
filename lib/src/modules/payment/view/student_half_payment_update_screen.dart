import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../models/payment_model_class/student_half_payment_model.dart';
import '../../../provider/bloc_provider/date_picker_bloc/date_picker_bloc.dart';
import '../../../res/color/app_color.dart';
import '../bloc/student_half_payment/student_half_payment_bloc.dart';

class StudentHalfPaymentUpdateScreen extends StatefulWidget {
  final int studentId;
  final int classHasCatId;
  final String customId;
  const StudentHalfPaymentUpdateScreen({
    super.key,
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
  final TextEditingController _classFees = TextEditingController();

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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.failureMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if (state is StudentHalfPaymentUpdateSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.halfPaymentUpdateMsg),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is StudentPaymentUpdateSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.paymentUpdateMsg),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is StudentHalfPaymentDeleteSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.halfPaymentDeleteMsg),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
          ),
          BlocListener<DatePickerBloc, DatePickerState>(
            listener: (context, state) {
              if (state is DatePickerFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if (state is ClassEndDateSuccessState) {
                if (_selectMonthController.text != state.formatDate) {
                  _selectMonthController.text = state.formatDate;

                  try {
                    final DateTime selectedDate = DateFormat('yyyy-MMM')
                        .parse(_selectMonthController.text);
                    final String paymentMonth =
                        DateFormat('yyyy-MM').format(selectedDate);

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
            },
          ),
        ],
        child: Column(
          children: [
            BlocBuilder<DatePickerBloc, DatePickerState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildDatePickerCard(
                    controller: _selectMonthController,
                    hintText: 'Select Month',
                    icon: Icons.date_range,
                    onTap: () {
                      context
                          .read<DatePickerBloc>()
                          .add(ClassEndDatePicker(context: context));
                    },
                  ),
                );
              },
            ),
            Expanded(
              child:
                  BlocBuilder<StudentHalfPaymentBloc, StudentHalfPaymentState>(
                builder: (context, state) {
                  if (state is StudentHalfPaymentProcess) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3.0,
                      ),
                    );
                  } else if (state is StudentHalfPaymentFailure) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.error, color: Colors.red, size: 40),
                          const SizedBox(height: 8),
                          Text(
                            state.failureMessage,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is StudentHalfPaymentSuccess) {
                    if (state.studentHalfPaymentModel.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.no_accounts, size: 40),
                            SizedBox(height: 8),
                            Text('No data found',
                                style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: state.studentHalfPaymentModel.length,
                      itemBuilder: (context, index) {
                        final payment = state.studentHalfPaymentModel[index];
                        return buildPaymentCard(payment);
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('Unexpected state',
                          style: TextStyle(fontSize: 18)),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePickerCard({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(8),
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.calendar_today, color: Colors.teal),
          onPressed: onTap,
        ),
      ),
    );
  }

  Widget buildPaymentCard(StudentHalfPaymentModel payment) {
    final currencyFormatter = NumberFormat.currency(
        locale: 'en_LK', symbol: 'LKR ', decimalDigits: 2);

    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
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
                  color: Colors.white, // White text for better contrast
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fees: ${currencyFormatter.format(payment.fees ?? 0.0)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
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
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Attendance Count: ${payment.attendanceCount ?? 0}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
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
                    Flexible(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (payment.amount != null &&
                              payment.paymentStatus != 0) {
                            showPaymentUpdateDialog(
                                context: context,
                                classFeesController: _classFees,
                                fees: payment.fees ?? 0.00,
                                amount: payment.amount ?? 0.00,
                                cancel: () {
                                  Navigator.of(context).pop();
                                },
                                update: () {
                                  if (_classFees.text.isNotEmpty &&
                                      payment.paymentStatus != 0) {
                                    StudentHalfPaymentModel halfPaymentModel =
                                        StudentHalfPaymentModel(
                                      paymentId: payment.paymentId,
                                      paymentFor: payment
                                          .paymentFor, // Include necessary fields
                                      amount:
                                          double.parse(_classFees.text.trim()),
                                      fees: payment.fees,
                                      attendanceCount: payment.attendanceCount,
                                    );

                                    final msg = _sendUpdateToMG(
                                        payment.className.toString(),
                                        payment.categoryName.toString(),
                                        "update");
                                    // Perform the half payment update action here
                                    // Example: Call a function or dispatch an event
                                    context.read<StudentHalfPaymentBloc>().add(
                                          UpdateStudentPaymentEvent(
                                              studentHalfPaymentModel:
                                                  halfPaymentModel,
                                              msg: msg),
                                        );
                                  }
                                });
                          }
                        },
                        icon: const Icon(Icons.payment, color: Colors.white),
                        label: const Text("Update",
                            overflow: TextOverflow.ellipsis),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                        ),
                      ),
                    ),
                    Flexible(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (payment.paymentStatus != 0) {
                            showDeleteConfirmationDialog(
                              context: context,
                              onConfirm: () {
                                final msg = _sendUpdateToMG(
                                        payment.className.toString(),
                                        payment.categoryName.toString(),
                                        "delete");
                                context.read<StudentHalfPaymentBloc>().add(
                                      StudentPaymentDeleteEvent(
                                          paymentId: payment.paymentId!,
                                          msg: msg),
                                    );
                              },
                            );
                          }
                        },
                        icon: const Icon(Icons.delete, color: Colors.white),
                        label: const Text("Delete Payment",
                            overflow: TextOverflow.ellipsis),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                      ),
                    ),
                    Flexible(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (payment.attendanceCount == 1 &&
                              payment.amount != null &&
                              payment.amount != null &&
                              payment.fees == payment.amount) {
                            final double halfPay = payment.amount! / 2;

                            // Create an updated StudentHalfPaymentModel
                            StudentHalfPaymentModel halfPaymentModel =
                                StudentHalfPaymentModel(
                              paymentId: payment.paymentId,
                              paymentFor: payment
                                  .paymentFor, // Include necessary fields
                              amount: halfPay,
                              fees: payment.fees,
                              attendanceCount: payment.attendanceCount,
                            );

                            final msg = _sendUpdateToMG(
                                        payment.className.toString(),
                                        payment.categoryName.toString(),
                                        "half payment update");
                            // Perform the half payment update action here
                            // Example: Call a function or dispatch an event
                            context.read<StudentHalfPaymentBloc>().add(
                                  UpdateStudentHalfPaymentEvent(
                                      studentHalfPaymentModel: halfPaymentModel,
                                      msg: msg),
                                );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Half payment update failed: Invalid data."),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.update, color: Colors.white),
                        label: const Text("Half Payment",
                            overflow: TextOverflow.ellipsis),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void showPaymentUpdateDialog({
    required BuildContext context,
    required TextEditingController classFeesController,
    required double fees,
    required double amount,
    required Function()? update,
    required Function()? cancel,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Payment Update",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Class Fees: LKR ${fees.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Amount Paid: LKR ${amount.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: classFeesController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'New Class Fees',
                  hintText: 'Enter updated fees',
                  prefixIcon: const Icon(Icons.money, color: Colors.green),
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
            ],
          ),
          actions: [
            TextButton(
              onPressed: cancel,
              child: const Text("Cancel",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            ElevatedButton(
              onPressed: update,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Update",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void showDeleteConfirmationDialog({
    required BuildContext context,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Confirm Deletion",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Are you sure you want to delete this payment? This action cannot be undone.",
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                "Cancel",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                onConfirm(); // Perform the delete action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                "Confirm",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  String _sendUpdateToMG(String className, String categoryName, String name) {
    final currentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    final message =
        "Payment for ${widget.customId}'s $className $categoryName $name on $currentDate";

    return message;
  }
}
