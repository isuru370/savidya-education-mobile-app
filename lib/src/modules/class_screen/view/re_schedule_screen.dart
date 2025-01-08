import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/button/app_main_button.dart';
import '../../../models/class_attendance/class_attendance.dart';
import '../../../models/class_schedule/class_halle_model.dart';
import '../../../provider/bloc_provider/date_picker_bloc/date_picker_bloc.dart';
import '../../../provider/cubit_provider/dropdown_button_cubit/dropdown_button_cubit.dart';
import '../../../provider/cubit_provider/dropdown_button_cubit/dropdown_button_state.dart';
import '../../../res/color/app_color.dart';
import '../bloc/class_attendance/class_attendance_bloc.dart';
import '../bloc/class_hall_bloc/class_halls_bloc.dart';
import '../bloc/days_bloc/days_bloc.dart';

class ReScheduleScreen extends StatefulWidget {
  final ClassAttendanceModelClass classAttendanceModelClass;
  final String scheduleText;

  const ReScheduleScreen({
    super.key,
    required this.classAttendanceModelClass,
    required this.scheduleText,
  });

  @override
  State<ReScheduleScreen> createState() => _ReScheduleScreenState();
}

class _ReScheduleScreenState extends State<ReScheduleScreen> {
  final TextEditingController _scheduleDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  String? dayName;
  int? hallId;

  TimeOfDay _selectedTime = const TimeOfDay(hour: 0, minute: 0);

  @override
  void initState() {
    super.initState();
    context.read<ClassHallsBloc>().add(GetClassHallsEvent());
    context.read<ClassAttendanceBloc>().add(GetClassAttendanceEvent(
        classCatId:
            widget.classAttendanceModelClass.classCategoryHasStudentId!));

    if (widget.scheduleText != "new_day") {
      _scheduleDateController.text =
          widget.classAttendanceModelClass.classDate ?? '';
      _startTimeController.text =
          widget.classAttendanceModelClass.classStartTime ?? '';
      _endTimeController.text =
          widget.classAttendanceModelClass.classEndTime ?? '';
      dayName = widget.classAttendanceModelClass.dayDayName;
      hallId = widget.classAttendanceModelClass.classHallId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          widget.scheduleText == "new_day" ? "Add New Class" : "Class Update",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: ColorUtil.tealColor[10],
      ),
      body: BlocListener<ClassAttendanceBloc, ClassAttendanceState>(
        listener: (context, state) {
          if (state is ClassAttendanceFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.failureMessage)),
            );
          } else if (state is ClassAttendanceInsertSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(widget.scheduleText == "new_day"
                    ? "Class day added successfully!"
                    : "Class day updated successfully!"),
              ),
            );
            if (widget.scheduleText == "new_day") {
              clearTextFields();
            }
          }
        },
        child: BlocBuilder<ClassAttendanceBloc, ClassAttendanceState>(
          builder: (context, state) {
            if (state is ClassAttendanceProcess) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    BlocBuilder<DatePickerBloc, DatePickerState>(
                      builder: (context, state) {
                        if (state is DatePickerFailure) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          });
                        } else if (state is FutureDatePikerSuccessState) {
                          _scheduleDateController.text = state.futureDate;
                        }
                        return _buildDatePickerCard(
                          controller: _scheduleDateController,
                          hintText: widget.scheduleText == "new_day"
                              ? 'New Class Schedule Date'
                              : 'Update Class Schedule Date',
                          icon: Icons.date_range,
                          onTap: () {
                            context
                                .read<DatePickerBloc>()
                                .add(FutureDatePickerEvent(context: context));
                          },
                        );
                      },
                    ),
                    _buildTimePickerCard(
                      controller: _startTimeController,
                      hintText: 'Class Start Time',
                      icon: Icons.timer,
                      onTap: () {
                        _showTimePicker("startTime");
                      },
                    ),
                    _buildTimePickerCard(
                      controller: _endTimeController,
                      hintText: 'Class End Time',
                      icon: Icons.timer_off,
                      onTap: () {
                        _showTimePicker("endTime");
                      },
                    ),
                    BlocBuilder<DaysBloc, DaysState>(
                      builder: (context, state) {
                        if (state is DaysLoaded) {
                          return _buildDropdownCard(
                            widget: selectScheduleDay(state.days),
                            hintText: 'Select a Day',
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                    BlocBuilder<ClassHallsBloc, ClassHallsState>(
                      builder: (context, state) {
                        if (state is GetClassHallsSuccess) {
                          return _buildDropdownCard(
                            widget: selectClassHall(state.classHallList),
                            hintText: 'Select a Hall',
                          );
                        } else if (state is GetClassHallsFailure) {
                          return Text('Error: ${state.failureMessage}');
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    AppMainButton(
                      testName: widget.scheduleText == "new_day"
                          ? "Add New Class Day"
                          : "Update Class Day",
                      onTap: () {
                        if (widget.scheduleText == "new_day") {
                          newScheduleDaySave();
                        } else {
                          reScheduleSave();
                        }
                      },
                      height: 50,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDatePickerCard({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4.0,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: Icon(icon),
        title: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
          ),
          readOnly: true,
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _buildTimePickerCard({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4.0,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: Icon(icon),
        title: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
          ),
          readOnly: true,
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _buildDropdownCard({
    required Widget widget,
    required String hintText,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hintText,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            widget,
          ],
        ),
      ),
    );
  }

  void _showTimePicker(String timeType) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((pickedTime) {
      if (pickedTime != null) {
        setState(() {
          _selectedTime = pickedTime;
          if (timeType == "startTime") {
            _startTimeController.text = _selectedTime.format(context);
          } else {
            _endTimeController.text = _selectedTime.format(context);
          }
        });
      }
    });
  }

  Widget selectScheduleDay(List<String> days) {
    return DropdownButton<String>(
      isExpanded: true,
      underline: const SizedBox(),
      value: dayName,
      items: days.map((String scheduleDay) {
        return DropdownMenuItem<String>(
          value: scheduleDay,
          child: Text(scheduleDay),
        );
      }).toList(),
      onChanged: (String? newDay) {
        setState(() {
          dayName = newDay;
        });
      },
    );
  }

  Widget selectClassHall(List<ClassHalleModelClass> classHall) {
    return BlocBuilder<DropdownButtonCubit, DropdownButtonState>(
      builder: (context, state) {
        return DropdownButton<ClassHalleModelClass>(
          isExpanded: true,
          underline: const SizedBox(),
          iconSize: 40,
          hint: const Text('Select a Hall'),
          icon: const Icon(Icons.arrow_drop_down),
          value: state.selectHall,
          items: classHall.map((ClassHalleModelClass hall) {
            return DropdownMenuItem<ClassHalleModelClass>(
              value: hall,
              child: Text("${hall.hallId} ${hall.hallName}"),
            );
          }).toList(),
          onChanged: (ClassHalleModelClass? newHall) {
            if (newHall != null) {
              context.read<DropdownButtonCubit>().selectHall(newHall);
              hallId = newHall.id;
            }
          },
        );
      },
    );
  }

  bool validation() {
    return _scheduleDateController.text.isNotEmpty &&
        _startTimeController.text.isNotEmpty &&
        _endTimeController.text.isNotEmpty &&
        dayName != null &&
        hallId != null;
  }

  Future<bool> _showConfirmationDialog() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(widget.scheduleText == "new_day"
                  ? "Add New Class Day"
                  : "Update Class Day"),
              content: const Text("Are you sure you want to proceed?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("Confirm"),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<void> newScheduleDaySave() async {
    if (validation()) {
      bool confirmed = await _showConfirmationDialog();
      if (confirmed) {
        ClassAttendanceModelClass modelClass = ClassAttendanceModelClass(
          startMonth: widget.classAttendanceModelClass.startMonth,
          endMonth: widget.classAttendanceModelClass.endMonth,
          classStatus: 0,
          classCategoryHasStudentId:
              widget.classAttendanceModelClass.classCategoryHasStudentId,
          classStartTime: _startTimeController.text.trim(),
          classEndTime: _endTimeController.text.trim(),
          dayDayName: dayName,
          onGoing: 1,
          classHallId: hallId,
          classDate: _scheduleDateController.text.trim(),
        );
        // ignore: use_build_context_synchronously
        context
            .read<ClassAttendanceBloc>()
            .add(ClassAttendanceMarkEvent(attendanceModelClass: modelClass));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter correct data")),
      );
    }
  }

  void reScheduleSave() {
    if (validation()) {
      ClassAttendanceModelClass modelClass = ClassAttendanceModelClass(
        classAttId: widget.classAttendanceModelClass.classAttId,
        classStatus: 2,
        classStartTime: _startTimeController.text.trim(),
        classEndTime: _endTimeController.text.trim(),
        dayDayName: dayName,
        classHallId: hallId,
        classDate: _scheduleDateController.text.trim(),
      );
      context
          .read<ClassAttendanceBloc>()
          .add(ClassReScheduleEvent(attendanceModelClass: modelClass));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter correct data")),
      );
    }
  }

  void clearTextFields() {
    _scheduleDateController.clear();
    _startTimeController.clear();
    _endTimeController.clear();
    dayName = null;
    hallId = null;
  }
}
