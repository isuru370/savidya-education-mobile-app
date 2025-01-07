import 'package:aloka_mobile_app/src/modules/payment/components/student_free_card_widget.dart';
import 'package:flutter/material.dart';

class BuildStudentHalfListWidget extends StatelessWidget {
  final String className;
  final String categoryName;
  final String gradeName; // Expecting a date string like "2025-01-01 14:30:00"
  final int studentFreeCard;
  final VoidCallback onPayPressed;

  const BuildStudentHalfListWidget({
    super.key,
    required this.className,
    required this.categoryName,
    required this.gradeName,
    required this.onPayPressed,
    required this.studentFreeCard,
  });

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
                      ? const Text(
                          'FreeCard',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            studentFreeCard == 1
                ? const StudentFreeCardWidget()
                : Column(
                    children: [
                      ElevatedButton(
                        onPressed: onPayPressed,
                        child: const Text('Check Payment'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
