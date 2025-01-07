import 'package:flutter/material.dart';

class AttendanceCard extends StatelessWidget {
  final String studentName;
  final String attendanceStatus;
  final String customId;
  final String whatsappMobile;

  const AttendanceCard({
    Key? key,
    required this.studentName,
    required this.attendanceStatus,
    required this.customId,
    required this.whatsappMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Subtle shadow for depth
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Inner padding for content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    studentName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Chip(
                  label: Text(
                    attendanceStatus.toUpperCase(),
                    style: TextStyle(
                      color: attendanceStatus.toLowerCase() == 'present'
                          ? Colors.white
                          : Colors.black87,
                    ),
                  ),
                  backgroundColor: attendanceStatus.toLowerCase() == 'present'
                      ? Colors.green
                      : Colors.redAccent,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.badge,
                  color: Colors.blueGrey,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  "Custom ID: $customId",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.phone,
                  color: Colors.blueGrey,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  whatsappMobile,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
 

