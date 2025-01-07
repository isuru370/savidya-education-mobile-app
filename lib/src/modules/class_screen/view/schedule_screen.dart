import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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

class ScheduleScreen extends StatefulWidget {
  final int? classCatId;
  const ScheduleScreen({super.key, required this.classCatId});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final TextEditingController _classStartDateController =
      TextEditingController();
  final TextEditingController _classEndDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  String? dayName;
  int? hallId;

  DateTime? classStart;
  DateTime? classEnd;

  TimeOfDay _selectedTime = const TimeOfDay(hour: 0, minute: 0);

  @override
  void initState() {
    super.initState();
    context.read<ClassHallsBloc>().add(GetClassHallsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text(
          "Schedule",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: ColorUtil.tealColor[10],
      ),
      body: BlocListener<ClassAttendanceBloc, ClassAttendanceState>(
        listener: (context, state) {
          if (state is ClassAttendanceFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failureMessage),
              ),
            );
          } else if (state is ClassAttendanceInsertSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage),
              ),
            );
            clearTextFelid();
          }
        },
        child: BlocBuilder<ClassAttendanceBloc, ClassAttendanceState>(
          builder: (context, state) {
            if (state is ClassAttendanceProcess) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(
                    16.0), // Adding padding around the column
                child: Column(
                  children: [
                    BlocBuilder<DatePickerBloc, DatePickerState>(
                      builder: (context, state) {
                        if (state is DatePickerFailure) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                              ),
                            );
                          });
                        } else if (state is ClassStartDateSuccessState) {
                          _classStartDateController.text = state.formatDate;
                          classStart = state.classStartDate;
                        }
                        return _buildDatePickerCard(
                          controller: _classStartDateController,
                          hintText: 'Class Start Month',
                          icon: Icons.date_range,
                          onTap: () {
                            context
                                .read<DatePickerBloc>()
                                .add(ClassStartDatePicker(context: context));
                          },
                        );
                      },
                    ),
                    BlocBuilder<DatePickerBloc, DatePickerState>(
                      builder: (context, state) {
                        if (state is DatePickerFailure) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                              ),
                            );
                          });
                        } else if (state is ClassEndDateSuccessState) {
                          _classEndDateController.text = state.formatDate;
                          classEnd = state.classEndDate;
                        }
                        return _buildDatePickerCard(
                          controller: _classEndDateController,
                          hintText: 'Class End Month',
                          icon: Icons.date_range,
                          onTap: () {
                            context
                                .read<DatePickerBloc>()
                                .add(ClassEndDatePicker(context: context));
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
                            hintText: 'Select a Grade',
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
                        testName: "Save",
                        onTap: () {
                          classScheduleSave();
                        },
                        height: 50),
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

  Widget _buildDropdownCard(
      {required Widget widget, required String hintText}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(hintText,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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
    return BlocBuilder<DaysBloc, DaysState>(
      builder: (context, state) {
        return DropdownButton<String>(
          isExpanded: true,
          underline: const SizedBox(),
          iconSize: 40,
          hint: const Text('Select a Day'),
          icon: const Icon(Icons.arrow_drop_down),
          value: dayName,
          items: days.map((String scheduleDay) {
            return DropdownMenuItem<String>(
              value: scheduleDay,
              child: Text(scheduleDay),
            );
          }).toList(),
          onChanged: (String? newDay) {
            if (newDay != null) {
              context.read<DaysBloc>().add(SelectDay(selectedDay: newDay));
              dayName = newDay;
            }
          },
        );
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

  validation() {
    if (_classStartDateController.text.isNotEmpty &&
        _classEndDateController.text.isNotEmpty &&
        _startTimeController.text.isNotEmpty &&
        _endTimeController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  classScheduleSave() {
    if (validation()) {
      List<dynamic> dates = getDatesBetween(classStart!, classEnd!, dayName!);
      for (int i = 0; i < dates.length; i++) {
        ClassAttendanceModelClass modelClass = ClassAttendanceModelClass(
          startMonth: _classStartDateController.text.trim(),
          endMonth: _classEndDateController.text.trim(),
          classStatus: 0,
          classCategoryHasStudentId: widget.classCatId,
          classStartTime: _startTimeController.text.trim(),
          classEndTime: _endTimeController.text.trim(),
          dayDayName: dayName,
          onGoing: 1,
          classHallId: hallId,
          classDate: '${dates[i]['classDay']}',
        );
        context
            .read<ClassAttendanceBloc>()
            .add(ClassAttendanceMarkEvent(attendanceModelClass: modelClass));
      }
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter correct data"),
          ),
        );
      });
    }
  }

  clearTextFelid() {
    _classStartDateController.clear();
    _classEndDateController.clear();
    _startTimeController.clear();
    _endTimeController.clear();
    context.read<DropdownButtonCubit>().selectHall(null);
    dayName = null;
  }

  List<Map<String, String>> getDatesBetween(
      DateTime start, DateTime end, String dayName) {
    int targetWeekday;
    switch (dayName) {
      case 'Monday':
        targetWeekday = DateTime.monday;
        break;
      case 'Tuesday':
        targetWeekday = DateTime.tuesday;
        break;
      case 'Wednesday':
        targetWeekday = DateTime.wednesday;
        break;
      case 'Thursday':
        targetWeekday = DateTime.thursday;
        break;
      case 'Friday':
        targetWeekday = DateTime.friday;
        break;
      case 'Saturday':
        targetWeekday = DateTime.saturday;
        break;
      case 'Sunday':
        targetWeekday = DateTime.sunday;
        break;
      default:
        throw ArgumentError('Invalid day name');
    }

    List<Map<String, String>> dates = [];
    DateTime current = start;

    while (current.weekday != targetWeekday) {
      current = current.add(const Duration(days: 1));
    }

    while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(current);
      dates.add({'classDay': formattedDate});
      current = current.add(const Duration(days: 7));
    }

    return dates;
  }
}
