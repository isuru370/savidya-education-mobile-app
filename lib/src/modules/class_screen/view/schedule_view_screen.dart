import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aloka_mobile_app/src/modules/class_screen/bloc/class_has_category/class_has_category_bloc.dart';
import '../../../res/color/app_color.dart';

class ScheduleViewScreen extends StatefulWidget {
  final int classId;
  const ScheduleViewScreen({super.key, required this.classId});

  @override
  State<ScheduleViewScreen> createState() => _ScheduleViewScreenState();
}

class _ScheduleViewScreenState extends State<ScheduleViewScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<ClassHasCategoryBloc>()
        .add(GetUniqueClassHasCatEvent(classId: widget.classId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text(
          "Schedule View",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: ColorUtil.tealColor[10],
      ),
      body: BlocBuilder<ClassHasCategoryBloc, ClassHasCategoryState>(
        builder: (context, state) {
          if (state is ClassHasCategoryProcess) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetUniqueClassHasCatSuccess) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: state.uniqueClassHasCatList.length,
                itemBuilder: (context, index) {
                  final uniqueClassItem = state.uniqueClassHasCatList[index];
                  return Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  uniqueClassItem.className!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  uniqueClassItem.subjectName!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
                                  decoration: BoxDecoration(
                                    color: ColorUtil.tealColor[10],
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Text(
                                    uniqueClassItem.categoryName!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed('/schedule_screen',
                                          arguments: {
                                        'classCatId':
                                            uniqueClassItem.classHasCatId,
                                      });
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: ColorUtil.tealColor[10],
                                  iconColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 8.0),
                                ),
                                child: Text(
                                  'Class Schedule',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: ColorUtil.whiteColor[10]),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      '/class_schedule_attendance_screen',
                                      arguments: {
                                        'classHasCatId':
                                            uniqueClassItem.classHasCatId,
                                        'classId': uniqueClassItem.classId,
                                      });
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: ColorUtil.tealColor[10],
                                  iconColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 8.0),
                                ),
                                child: Text(
                                  'Class Details',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: ColorUtil.whiteColor[10]),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  String? selectedDay;
                                  List<String> days = [
                                    "Sunday",
                                    "Monday",
                                    "Tuesday",
                                    "Wednesday",
                                    "Thursday",
                                    "Friday",
                                    "Saturday"
                                  ];

                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Select Day Name"),
                                        content: StatefulBuilder(
                                          builder: (context, setState) {
                                            return DropdownButton<String>(
                                              value: selectedDay,
                                              hint: const Text("Select a day"),
                                              isExpanded: true,
                                              items: days.map((String day) {
                                                return DropdownMenuItem<String>(
                                                  value: day,
                                                  child: Text(day),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  selectedDay = newValue;
                                                });
                                              },
                                            );
                                          },
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              if (selectedDay != null) {
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog
                                                Navigator.of(context).pushNamed(
                                                  '/class_attendance_list_screen',
                                                  arguments: {
                                                    'classHasCatId':
                                                        uniqueClassItem
                                                            .classHasCatId!,
                                                    'dayName':
                                                        selectedDay, // Pass the selected day
                                                  },
                                                );
                                              }
                                            },
                                            child: const Text("OK"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: ColorUtil.tealColor[10],
                                  iconColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 8.0),
                                ),
                                child: Text(
                                  'Class List Dalete',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: ColorUtil.whiteColor[10]),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: Text(
                'Data not found',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
        },
      ),
    );
  }
}
