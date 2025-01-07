import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for formatting dates
import 'package:aloka_mobile_app/src/models/class_schedule/class_schedule.dart';
import 'package:aloka_mobile_app/src/res/color/app_color.dart';

class SingleClassViewScreen extends StatefulWidget {
  final ClassScheduleModelClass classScheduleModelClass;
  const SingleClassViewScreen(
      {super.key, required this.classScheduleModelClass});

  @override
  State<SingleClassViewScreen> createState() => _SingleClassViewScreenState();
}

class _SingleClassViewScreenState extends State<SingleClassViewScreen> {
  @override
  Widget build(BuildContext context) {
    final classSchedule = widget.classScheduleModelClass;

    return Scaffold(
      backgroundColor: ColorUtil.tealColor[10], // Light background
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: ColorUtil.tealColor[10],
        title: const Text(
          'Class Details',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.white,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section for Class Name
                  _buildDetailRow(
                    icon: Icons.class_,
                    title: 'Class Name',
                    value: classSchedule.className ?? 'N/A',
                  ),
                  const Divider(),

                  // Section for Teacher Name
                  _buildDetailRow(
                    icon: Icons.person,
                    title: 'Teacher Name',
                    value: classSchedule.teacherFullName ?? 'N/A',
                  ),
                  const Divider(),

                  // Section for Teacher Initials
                  _buildDetailRow(
                    icon: Icons.school,
                    title: 'Teacher Initials',
                    value: classSchedule.teacherInitialName ?? 'N/A',
                  ),
                  const Divider(),

                  // Section for Subject
                  _buildDetailRow(
                    icon: Icons.book,
                    title: 'Subject',
                    value: classSchedule.subjectName ?? 'N/A',
                  ),
                  const Divider(),

                  // Section for Grade
                  _buildDetailRow(
                    icon: Icons.grade,
                    title: 'Grade',
                    value: classSchedule.gradeName ?? 'N/A',
                  ),
                  const Divider(),

                  // Section for Is Active
                  _buildDetailRow(
                    icon: Icons.check_circle,
                    title: 'Is Active',
                    value: classSchedule.isActive == 1 ? 'Yes' : 'No',
                    color:
                        classSchedule.isActive == 1 ? Colors.green : Colors.red,
                  ),
                  const Divider(),

                  // Section for Is Ongoing
                  _buildDetailRow(
                    icon: Icons.timelapse,
                    title: 'Is Ongoing',
                    value: classSchedule.isOngoing == 1 ? 'Yes' : 'No',
                    color: classSchedule.isOngoing == 1
                        ? Colors.green
                        : Colors.red,
                  ),

                  const Divider(),
                  _buildDetailRow(
                    icon: Icons.calendar_today,
                    title: 'Join Date',
                    value: _formatDate(classSchedule.createdAt),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build a detailed information row with an icon
  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String value,
    Color color = Colors.grey,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: ColorUtil.tealColor[10], size: 30),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper method to format date
  String _formatDate(DateTime? date) {
    if (date == null) {
      return 'N/A';
    }
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
