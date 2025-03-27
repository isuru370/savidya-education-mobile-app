import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/class_attendance/class_attendance_list_model.dart';
import '../../../res/color/app_color.dart';
import '../bloc/class_attendance/class_attendance_bloc.dart';
import '../bloc/class_hall_bloc/class_halls_bloc.dart';

class ClassAttendanceListUpdateScreen extends StatefulWidget {
  final int classHasCatId;
  final String dayName;

  const ClassAttendanceListUpdateScreen({
    super.key,
    required this.classHasCatId,
    required this.dayName,
  });

  @override
  State<ClassAttendanceListUpdateScreen> createState() =>
      _ClassAttendanceListUpdateScreenState();
}

class _ClassAttendanceListUpdateScreenState
    extends State<ClassAttendanceListUpdateScreen> {
  List<ClassAttendanceListModel> classAttendanceList = [];

  @override
  void initState() {
    super.initState();
    context.read<ClassHallsBloc>().add(GetClassHallsEvent());
    context.read<ClassAttendanceBloc>().add(
          ClassAttendanceListEvent(
            classHasCatId: widget.classHasCatId,
            dayOfWeek: widget.dayName,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  /// Builds the App Bar
  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: 100,
      title: const Text(
        "Class Attendance Update",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      backgroundColor: ColorUtil.tealColor[10],
    );
  }

  /// Builds the Body with BlocListener & BlocBuilder
  Widget _buildBody() {
    return BlocListener<ClassAttendanceBloc, ClassAttendanceState>(
      listener: (context, state) {
        if (state is ClassAttendanceFailure) {
          _showSnackBar(state.failureMessage, Colors.red);
        } else if (state is ClassAttendanceListSuccess) {
          _showSnackBar(state.classAttendanceListSuccess, Colors.green);
        }
      },
      child: BlocBuilder<ClassAttendanceBloc, ClassAttendanceState>(
        builder: (context, state) {
          if (state is ClassAttendanceProcess) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetClassAttendanceListSuccess) {
            classAttendanceList = state.classAttendanceList;
            return _buildAttendanceList();
          }
          return const SizedBox();
        },
      ),
    );
  }

  /// Builds the List of Attendance Records
  Widget _buildAttendanceList() {
    return ListView.builder(
      itemCount: classAttendanceList.length,
      itemBuilder: (context, index) {
        final classAttendanceData = classAttendanceList[index];
        return _buildAttendanceCard(classAttendanceData);
      },
    );
  }

  /// Builds an individual Attendance Card
  Widget _buildAttendanceCard(ClassAttendanceListModel data) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ListTile(
          title: Text(
            data.classDay ?? "Unknown Day",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              _buildInfoText("Start Time: ${data.startTime}"),
              _buildInfoText("End Time: ${data.endTime}"),
              _buildInfoText("Day: ${data.dayOfWeek}"),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper method to create formatted text
  Widget _buildInfoText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
    );
  }

  /// Builds the bottom navigation bar
  Widget _buildBottomNavigationBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton(
          onPressed: _handleDeleteAttendance,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Delete List', style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }

  /// Handles attendance deletion
  void _handleDeleteAttendance() {
    for (final attendance in classAttendanceList) {
      context.read<ClassAttendanceBloc>().add(
            ClassAttendanceUpdateEvent(classAttendanceId: attendance.id),
          );
    }
  }

  /// Displays Snackbar messages
  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }
}
