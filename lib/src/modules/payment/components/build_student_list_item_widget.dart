import 'package:aloka_mobile_app/src/modules/payment/components/student_free_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuildStudentListItemWidget extends StatelessWidget {
  final String className;
  final String categoryName;
  final String gradeName;
  final String?
      lastPaymentDate; // Expecting a date string like "2025-01-01 14:30:00"
  final int studentFreeCard;
  final String? lastPaymentFor;
  final VoidCallback onPayPressed;

  const BuildStudentListItemWidget({
    super.key,
    required this.className,
    required this.categoryName,
    required this.gradeName,
    this.lastPaymentDate,
    this.lastPaymentFor,
    required this.onPayPressed,
    required this.studentFreeCard,
  });

  String _formatDate(String? date) {
    if (date == null) return "N/A";
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat('yyyy-MM-dd')
          .format(parsedDate); // Format as "2025-01-01"
    } catch (e) {
      return "N/A";
    }
  }

  String _formatTime(String? date) {
    if (date == null) return "N/A";
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat('HH:mm').format(parsedDate); // Format as "14:30"
    } catch (e) {
      return "N/A";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    className,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Category: $categoryName',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Grade: $gradeName',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  studentFreeCard == 1
                      ? const SizedBox()
                      : Text(
                          'Payment Date: ${_formatDate(lastPaymentDate)}',
                          style: TextStyle(
                            color: lastPaymentDate != null
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                  const SizedBox(height: 5),
                  studentFreeCard == 1
                      ? const Text(
                          'FreeCard',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        )
                      : Text(
                          'Payment Time: ${_formatTime(lastPaymentDate)}',
                          style: TextStyle(
                            color: lastPaymentDate != null
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                ],
              ),
            ),
            studentFreeCard == 1
                ? const StudentFreeCardWidget()
                : Column(
                    children: [
                      ElevatedButton(
                        onPressed: onPayPressed,
                        child: const Text('Pay'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        lastPaymentFor ?? "N/A",
                        style: TextStyle(
                          color: lastPaymentFor != null
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
