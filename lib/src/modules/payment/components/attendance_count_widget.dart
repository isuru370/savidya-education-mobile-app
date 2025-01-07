import 'package:flutter/material.dart';

class AttendanceCountWidget extends StatelessWidget {
  final String attendanceCount;
  const AttendanceCountWidget({super.key, required this.attendanceCount});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Attendance Count: $attendanceCount',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
