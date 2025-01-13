import 'package:aloka_mobile_app/src/modules/attendance/bloc/update_attendance/update_attendance_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../models/attendance/attendance.dart';
import '../../../res/color/app_color.dart';
import '../bloc/unique_attendance/unique_attendance_bloc.dart';

class StudentUniqueAttendance extends StatefulWidget {
  final int studentId;
  final int classCategoryHasStudentClassId;
  final int studentHasClassId;

  const StudentUniqueAttendance({
    super.key,
    required this.studentId,
    required this.classCategoryHasStudentClassId,
    required this.studentHasClassId,
  });

  @override
  State<StudentUniqueAttendance> createState() =>
      _StudentUniqueAttendanceState();
}

class _StudentUniqueAttendanceState extends State<StudentUniqueAttendance> {
  String? selectedMonth;

  @override
  void initState() {
    super.initState();
    // Trigger attendance data retrieval on initialization
    context.read<UniqueAttendanceBloc>().add(
          GetUniqueStudentAttendanceEvent(
            classCategoryHasStudentClassId:
                widget.classCategoryHasStudentClassId,
            studentId: widget.studentId,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: BlocBuilder<UniqueAttendanceBloc, UniqueAttendanceState>(
              builder: (context, state) {
                if (state is UniqueAttendanceProcess) {
                  return _buildLoadingIndicator();
                } else if (state is UniqueAttendanceFailure) {
                  return _buildError(state.failureMessage);
                } else if (state is UniqueAttendanceSuccess) {
                  // Filter attendance list based on selected month
                  final displayedAttendanceList = _filterAttendanceByMonth(
                    state.modelAttendance,
                    selectedMonth,
                  );
                  return _buildAttendanceList(displayedAttendanceList);
                } else {
                  return _buildNoDataAvailable();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: ColorUtil.tealColor[10],
      title: const Text(
        "Student Unique Attendance",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  Center _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Center _buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Center _buildNoDataAvailable() {
    return const Center(
      child: Text(
        "Data Not Found",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          labelText: "Select Month",
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        onTap: () async {
          // Open date picker dialog
          final selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000), // Set earliest selectable date
            lastDate: DateTime.now(), // Set latest selectable date
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Colors.teal, // Header background color
                    onPrimary: Colors.white, // Header text color
                    onSurface: Colors.black, // Body text color
                  ),
                ),
                child: child ?? const SizedBox(),
              );
            },
          );

          if (selectedDate != null) {
            setState(() {
              // Update selectedMonth with formatted value
              selectedMonth = DateFormat('yyyy-MMMM').format(selectedDate);
            });
          }
        },
        controller: TextEditingController(
          text: selectedMonth, // Display selected month
        ),
      ),
    );
  }

  ListView _buildAttendanceList(
      List<GetStudentAttendanceModelClass> attendanceList) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: attendanceList.length,
      itemBuilder: (context, index) {
        final attendanceData = attendanceList[index];
        return _buildAttendanceCard(attendanceData);
      },
    );
  }

  Card _buildAttendanceCard(GetStudentAttendanceModelClass attendanceData) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          _formatDate(attendanceData.classDate!),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              attendanceData.dayName!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.teal[600],
              ),
            ),
            Text(
              attendanceData.categoryName!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.teal[400],
              ),
            ),
          ],
        ),
        trailing: GestureDetector(
          onTap: () {
            if (attendanceData.attendanceStatus == 'present') {
            } else {
              _showAttendanceUpdateDialog(context, attendanceData);
            }
          },
          child: Text(
            attendanceData.attendanceStatus!,
            style: TextStyle(
              fontSize: 14,
              color: attendanceData.attendanceStatus == 'present'
                  ? Colors.green
                  : Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  void _showAttendanceUpdateDialog(
      BuildContext context, GetStudentAttendanceModelClass attendanceData) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return BlocProvider.value(
          value: context.read<UpdateAttendanceBloc>(),
          child: BlocListener<UpdateAttendanceBloc, UpdateAttendanceState>(
            listener: (context, state) {
              if (state is UpdateAttendanceFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage)),
                );
              } else if (state is UpdateAttendanceSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.successMessage)),
                );
                Navigator.of(dialogContext).pop();
              }
            },
            child: AlertDialog(
              title: const Text("Confirm Attendance Update"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Are you sure you want to mark this student as ${attendanceData.attendanceStatus!}?",
                  ),
                  const SizedBox(height: 8),
                  Text(attendanceData.dayName!),
                  const SizedBox(height: 4),
                  Text(
                    attendanceData.categoryName!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.teal[400],
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    if (attendanceData.classAttendanceId != null &&
                        attendanceData.classDate != null) {
                      context.read<UpdateAttendanceBloc>().add(
                            UpdateAttendance(
                              classAttendanceId: attendanceData.classAttendanceId!,
                              atDate: attendanceData.classDate!.toIso8601String(),
                              studentId: widget.studentId,
                              studentHasClassId: widget.studentHasClassId,
                            ),
                          );
                    } else {
                      
                    }
                  },
                  child: const Text("Confirm"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  List<GetStudentAttendanceModelClass> _filterAttendanceByMonth(
      List<GetStudentAttendanceModelClass> attendanceList, String? month) {
    if (month == null || month.isEmpty) return attendanceList;
    return attendanceList.where((attendance) {
      final attendanceMonth =
          DateFormat('yyyy-MMMM').format(attendance.classDate!);
      return attendanceMonth == month;
    }).toList();
  }
}
