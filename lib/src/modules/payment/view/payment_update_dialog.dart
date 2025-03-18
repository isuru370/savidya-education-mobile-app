import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/payment_model_class/last_payment_model_class.dart';

class PaymentUpdateDialog extends StatefulWidget {
  final TextEditingController classFeesController;
  final double fees;
  final double amount;
  final Function(int year, int month, int studentClassId, double updatedFees)?
      update;
  final Function()? cancel;
  final List<LastPaymentModelClass> studentLastPaymentList;

  const PaymentUpdateDialog({
    super.key,
    required this.classFeesController,
    required this.fees,
    required this.amount,
    required this.update,
    required this.cancel,
    required this.studentLastPaymentList,
  });

  @override
  State<PaymentUpdateDialog> createState() => _PaymentUpdateDialogState();
}

class _PaymentUpdateDialogState extends State<PaymentUpdateDialog> {
  late int selectedYear;
  late int selectedMonth;
  LastPaymentModelClass? selectedClass;
  int? studentHasStudentClassId;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    selectedYear = now.year;
    selectedMonth = now.month;
    selectedClass = widget.studentLastPaymentList.isNotEmpty
        ? widget.studentLastPaymentList.first
        : null;
    studentHasStudentClassId = selectedClass != null
        ? int.tryParse(selectedClass!.studentStudentClassId)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    List<int> years =
        List.generate(11, (index) => DateTime.now().year - 5 + index);
    List<int> months = List.generate(12, (index) => index + 1);

    final monthItems = months
        .map((month) => DropdownMenuItem<int>(
              value: month,
              child: Text(DateFormat('MMM').format(DateTime(2000, month))),
            ))
        .toList();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        // 🔹 Wrap content to prevent overflow
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // 🔹 Ensures column doesn't take extra space
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Payment Update",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text('Class Fees: LKR ${widget.fees.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text('Amount Paid: LKR ${widget.amount.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              _buildDropdown<int>(
                label: "Payment Year",
                value: selectedYear,
                items: years
                    .map((year) => DropdownMenuItem(
                          value: year,
                          child: Text(year.toString()),
                        ))
                    .toList(),
                onChanged: (newYear) => setState(() => selectedYear = newYear!),
              ),
              const SizedBox(height: 10),
              _buildDropdown<int>(
                label: "Payment Month",
                value: selectedMonth,
                items: monthItems,
                onChanged: (newMonth) =>
                    setState(() => selectedMonth = newMonth!),
              ),
              const SizedBox(height: 10),
              if (widget.studentLastPaymentList.isNotEmpty)
                _buildDropdown<LastPaymentModelClass>(
                  label: "Student Class",
                  value: selectedClass!,
                  items: widget.studentLastPaymentList
                      .map((student) => DropdownMenuItem(
                            value: student,
                            child: Text(
                              '${student.className} ${student.categoryName}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  onChanged: (newClass) => setState(() {
                    selectedClass = newClass!;
                    studentHasStudentClassId =
                        int.tryParse(newClass.studentStudentClassId);
                  }),
                ),
              const SizedBox(height: 10),
              const Text(
                "New Payment Amount",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: widget.classFeesController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'New Class Fees',
                  hintText: 'Enter updated fees',
                  prefixIcon: const Icon(Icons.money, color: Colors.green),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: widget.cancel,
                    child: const Text("Cancel",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (widget.update != null) {
                        double updatedFees =
                            double.tryParse(widget.classFeesController.text) ??
                                0.0;

                        if (studentHasStudentClassId != null) {
                          widget.update!(selectedYear, selectedMonth,
                              studentHasStudentClassId!, updatedFees);
                        } else {
                          _showSnackBar(context,
                              "Please select a student class.", Colors.red);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Update",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required T value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey),
          ),
          child: DropdownButton<T>(
            value: value,
            isExpanded: true,
            items: items,
            onChanged: onChanged,
            underline: const SizedBox(),
          ),
        ),
      ],
    );
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
