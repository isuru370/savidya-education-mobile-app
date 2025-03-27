import 'package:flutter/material.dart';

class BuildStudentTuteListItem extends StatelessWidget {
  final String className;
  final String categoryName;
  final String gradeName;
  final int studentFreeCard;
  final VoidCallback onPayPressed;

  const BuildStudentTuteListItem({
    super.key,
    required this.className,
    required this.categoryName,
    required this.gradeName,
    required this.studentFreeCard,
    required this.onPayPressed,
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
                  Text(
                    'Free Card: ${studentFreeCard == 1 ? 'Yes' : 'No'}',
                    style: TextStyle(
                        fontSize: 16,
                        color: studentFreeCard == 1 ? Colors.red : Colors.blue),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: onPayPressed,
                  child: const Text('Tute'),
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
