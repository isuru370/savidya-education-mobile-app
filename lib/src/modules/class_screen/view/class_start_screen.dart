import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../res/color/app_color.dart';
import '../bloc/class_attendance/class_attendance_bloc.dart';

class ClassStartScreen extends StatefulWidget {
  final int classCatId;
  final int classId;

  const ClassStartScreen({
    super.key,
    required this.classCatId,
    required this.classId,
  });

  @override
  State<ClassStartScreen> createState() => _ClassStartScreenState();
}

class _ClassStartScreenState extends State<ClassStartScreen> {
  String searchQuery = '';
  Map<String, int> classDateCheckMap = {};

  @override
  void initState() {
    super.initState();
    context
        .read<ClassAttendanceBloc>()
        .add(GetClassAttendanceEvent(classCatId: widget.classCatId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: ColorUtil.tealColor[10],
        title: const Text("Class Status"),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pushNamed('/home');
            },
            icon: const Icon(Icons.arrow_back)),
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
            context
                .read<ClassAttendanceBloc>()
                .add(GetClassAttendanceEvent(classCatId: widget.classCatId));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage),
              ),
            );
          }
        },
        child: Column(
          children: [
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
                builder: (context, state) {
                  if (state is ClassAttendanceFailure) {
                    return Center(
                      child: Text(state.failureMessage),
                    );
                  }
                  if (state is GetClassAttendanceSuccess) {
                    final filteredList =
                        state.classAttendanceList.where((teacher) {
                      // Parse the date from the teacher object
                      DateTime classDate =
                          DateFormat('yyyy-MM-dd').parse(teacher.classDate!);
                      DateTime today = DateTime.now();
                      today = DateTime(today.year, today.month,
                          today.day); // Only date comparison

                      // Include only classes on or after today
                      return teacher.classDate!.contains(searchQuery) &&
                          (classDate.isAtSameMomentAs(today) ||
                              classDate.isAfter(today));
                    }).toList();

                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final classAttItems = filteredList[index];
                        _updateCheckDate(classAttItems.classDate!);

                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          elevation: 4,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            title: Text(
                              classAttItems.classDate!,
                              style: const TextStyle(
                                fontSize:
                                    18.0, // Larger font size for classDate
                                fontWeight: FontWeight.bold, // Bold text
                                color: Colors
                                    .blue, // Highlight color for classDate
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  classAttItems.categoryName!,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black54,
                                  ),
                                ),
                                Text(
                                  '${classAttItems.classStartTime!} - ${classAttItems.classEndTime!}',
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            trailing: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.resolveWith<Color?>(
                                  (Set<WidgetState> states) {
                                    switch (_getButtonStatus(
                                        classAttItems.classDate!)) {
                                      case 1: // Today
                                        return ColorUtil.greenColor[10];
                                      case 2: // Future
                                        return ColorUtil.blueColor[10];
                                      default:
                                        return ColorUtil.whiteColor[18];
                                    }
                                  },
                                ),
                              ),
                              onPressed: () {
                                switch (_getButtonStatus(
                                    classAttItems.classDate!)) {
                                  case 1: // Today
                                    Navigator.of(context, rootNavigator: true)
                                        .pushNamed('/qr_code_read', arguments: {
                                      "classCatId": classAttItems
                                          .classCategoryHasStudentId,
                                      "attendanceId": classAttItems.classAttId,
                                    });
                                    break;
                                  default:
                                    break;
                                }
                              },
                              child: Text(
                                _getButtonText(classAttItems.classDate!),
                                style: const TextStyle(
                                    fontSize: 14.0, color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('No data available.'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

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
      classDateCheckMap[dateString] = 0; // Past (Remove this from the UI)
    } else if (date.isAfter(now)) {
      classDateCheckMap[dateString] = 2; // Future
    } else {
      classDateCheckMap[dateString] = 1; // Today
    }
  }

  int _getButtonStatus(String dateString) {
    return classDateCheckMap[dateString] ?? -1;
  }

  String _getButtonText(String dateString) {
    int status = _getButtonStatus(dateString);
    switch (status) {
      case 1:
        return 'Mark'; // Action for today
      case 2:
        return 'Pending'; // Action for future dates
      default:
        return ''; // No text for past/marked items
    }
  }
}
