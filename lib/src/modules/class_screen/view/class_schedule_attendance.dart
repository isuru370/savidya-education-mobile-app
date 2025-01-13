import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../res/color/app_color.dart';
import '../bloc/class_attendance/class_attendance_bloc.dart';

class ClassScheduleAttendance extends StatefulWidget {
  final int classCatId;
  final int classId;

  const ClassScheduleAttendance({
    super.key,
    required this.classCatId,
    required this.classId,
  });

  @override
  State<ClassScheduleAttendance> createState() => _ClassAttendanceState();
}

class _ClassAttendanceState extends State<ClassScheduleAttendance> {
  String searchQuery = '';
  Map<String, int> classDateCheckMap = {};

  @override
  void initState() {
    super.initState();
    _fetchAttendanceData();
  }

  // Fetch Attendance Data
  void _fetchAttendanceData() {
    context
        .read<ClassAttendanceBloc>()
        .add(GetClassAttendanceEvent(classCatId: widget.classCatId));
  }

  // Update Check Date Map
  void _updateCheckDate(String dateString) {
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    DateTime date;

    try {
      date = inputFormat.parse(dateString);
      date = DateTime(date.year, date.month, date.day);
    } catch (e) {
      log("Error parsing date: $e");
      return;
    }

    DateTime now = DateTime.now();
    now = DateTime(now.year, now.month, now.day);

    if (date.isBefore(now)) {
      classDateCheckMap[dateString] = 0; // Past
    } else if (date.isAfter(now)) {
      classDateCheckMap[dateString] = 2; // Future
    } else {
      classDateCheckMap[dateString] = 1; // Today
    }
  }

  // Get Button Status
  int _getButtonStatus(String dateString) {
    return classDateCheckMap[dateString] ?? -1;
  }

  // Get Button Text
  String _getButtonText(String dateString, int classStatus) {
    int status = _getButtonStatus(dateString);
    DateTime now = DateTime.now();
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    DateTime classDate = inputFormat.parse(dateString);

    // Normalize both dates to midnight for comparison
    DateTime currentDate = DateTime(now.year, now.month, now.day);
    DateTime classDateNormalized =
        DateTime(classDate.year, classDate.month, classDate.day);

    if (classStatus == 0 && classDateNormalized.isBefore(currentDate)) {
      return 'Class Not Held'; // Class date is in the past
    }

    switch (status) {
      case 0:
        return 'Marked';
      case 1:
        return 'Today Class';
      case 2:
        return 'Change';
      default:
        return '';
    }
  }

  // Handle Button Press
  void _handleButtonPress(dynamic classAttItems) {
    final buttonStatus = _getButtonStatus(classAttItems.classDate!);
    if (buttonStatus == 0) {
      Navigator.of(context, rootNavigator: true).pushNamed(
        '/class_student_attendance',
        arguments: {
          "class_name": classAttItems.className,
          "grade_name": classAttItems.gradeName,
          "category_name": classAttItems.categoryName,
          "class_cat_id": classAttItems.classCategoryHasStudentId,
          "class_date": classAttItems.classDate,
        },
      );
    } else if (buttonStatus == 2) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Choose an Action'),
            content: const Text('What do you want to do?'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.of(context, rootNavigator: true).pushNamed(
                    '/re_schedule_screen',
                    arguments: {
                      'class_attendance_list': classAttItems,
                      "schedule_text": 'new_day',
                    },
                  );
                },
                child: const Text('Add New Day'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.of(context, rootNavigator: true).pushNamed(
                    '/re_schedule_screen',
                    arguments: {
                      'class_attendance_list': classAttItems,
                      "schedule_text": 'update_day',
                    },
                  );
                },
                child: const Text('Update Day'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        },
      );
    }
  }

  // Get Button Color
  Color _getButtonColor(String dateString, int classStatus) {
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    DateTime now = DateTime.now();

    // Normalize both dates to remove the time component
    DateTime currentDate = DateTime(now.year, now.month, now.day);
    DateTime classDate = inputFormat.parse(dateString);
    DateTime classDateNormalized =
        DateTime(classDate.year, classDate.month, classDate.day);

    if (classStatus == 0 && classDateNormalized.isBefore(currentDate)) {
      return Colors.red; // Red for "Class Not Held"
    }

    switch (_getButtonStatus(dateString)) {
      case 0:
        return ColorUtil.blueColor[10]!;
      case 1:
        return ColorUtil.greenColor[10]!; // Green for "Today's Class"
      case 2:
        return ColorUtil.skyBlueColor[10]!;
      default:
        return ColorUtil.whiteColor[10]!;
    }
  }

// get text colors
  Color _getTextColor(String dateString, int classStatus) {
    if (classStatus == 0 &&
        DateFormat('yyyy-MM-dd').parse(dateString).isBefore(DateTime.now())) {
      return Colors.white; // White text for better visibility on red button
    }
    return Colors.white; // Default text color
  }

  // Build Attendance List
  Widget _buildAttendanceList(ClassAttendanceState state) {
    if (state is ClassAttendanceFailure) {
      return Center(child: Text(state.failureMessage));
    }
    if (state is GetClassAttendanceSuccess) {
      final filteredList = state.classAttendanceList.where((teacher) {
        return teacher.classDate!.contains(searchQuery);
      }).toList();

      return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final classAttItems = filteredList[index];
          _updateCheckDate(classAttItems.classDate!);

          return _buildAttendanceCard(classAttItems);
        },
      );
    } else {
      return const Center(child: Text('No data available.'));
    }
  }

  // Build Attendance Card
  Widget _buildAttendanceCard(dynamic classAttItems) {
    final isClassNotHeld = classAttItems.classStatus == 0 &&
        DateFormat('yyyy-MM-dd')
            .parse(classAttItems.classDate!)
            .isBefore(DateTime.now());

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          classAttItems.classDate!,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              classAttItems.categoryName!,
              style: const TextStyle(fontSize: 14.0, color: Colors.black54),
            ),
            Text(
              '${classAttItems.classStartTime!} - ${classAttItems.classEndTime!}',
              style: const TextStyle(fontSize: 12.0, color: Colors.grey),
            ),
          ],
        ),
        trailing: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              _getButtonColor(
                  classAttItems.classDate!, classAttItems.classStatus!),
            ),
          ),
          onPressed:
              isClassNotHeld ? null : () => _handleButtonPress(classAttItems),
          child: Text(
            _getButtonText(
                classAttItems.classDate!, classAttItems.classStatus!),
            style: TextStyle(
              fontSize: 14.0,
              color: _getTextColor(
                  classAttItems.classDate!, classAttItems.classStatus!),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: ColorUtil.tealColor[10],
          title: const Text("Class Schedule Attendance"),
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<ClassAttendanceBloc, ClassAttendanceState>(
              builder: (context, state) => _buildAttendanceList(state),
            ),
          ),
        ]));
  }
}
