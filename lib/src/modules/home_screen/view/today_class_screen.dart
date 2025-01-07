import 'package:aloka_mobile_app/src/modules/home_screen/bloc/today_classes/today_classes_bloc.dart';
import 'package:aloka_mobile_app/src/res/color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TodayClassScreen extends StatefulWidget {
  const TodayClassScreen({super.key});

  @override
  State<TodayClassScreen> createState() => _TodayClassScreenState();
}

class _TodayClassScreenState extends State<TodayClassScreen> {
  late TextEditingController _selectDateController;
  late String _currentDate;

  @override
  void initState() {
    super.initState();
    _currentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    _selectDateController = TextEditingController(text: _currentDate);
    context
        .read<TodayClassesBloc>()
        .add(GetTodayClassEvent(selectDate: _currentDate));
  }

  @override
  void dispose() {
    _selectDateController.dispose();
    super.dispose();
  }

  void _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _currentDate = DateFormat("yyyy-MM-dd").format(pickedDate);
        _selectDateController.text = _currentDate;
      });
      context
          .read<TodayClassesBloc>()
          .add(GetTodayClassEvent(selectDate: _currentDate));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text("Today Classes"),
        backgroundColor: ColorUtil.tealColor[10],
      ),
      body: Column(
        children: [
          // Date Picker Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _selectDateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Selected Date",
                      prefixIcon: const Icon(Icons.date_range),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onTap: () => _selectDate(context),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorUtil.greenColor[10],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Pick Date"),
                ),
              ],
            ),
          ),

          // Classes List Section
          Expanded(
            child: BlocBuilder<TodayClassesBloc, TodayClassesState>(
              builder: (context, state) {
                if (state is TodayClassesProcess) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TodayClassesSuccess) {
                  final todayClasses = state.todayClassesModel;

                  if (todayClasses.isEmpty) {
                    return const Center(
                      child: Text("No classes available for this date."),
                    );
                  }

                  return ListView.builder(
                    itemCount: todayClasses.length,
                    itemBuilder: (context, index) {
                      final classData = todayClasses[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    classData.className ?? "Unknown Class",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    classData.initialName ?? "Unknown Teacher",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Grade: ${classData.gradeName ?? "N/A"}",
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Subject: ${classData.subjectName ?? "N/A"}",
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Category: ${classData.categoryName ?? "N/A"}",
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Hall: ${classData.hallName ?? "N/A"}",
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Day: ${classData.classDay ?? "N/A"}",
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Start: ${classData.classStartTime ?? "--"}",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                  Text(
                                    "End: ${classData.classEndTime ?? "--"}",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Text(
                                    "Status: ",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  Text(
                                    classData.classStatus == 1
                                        ? "I'm going to hold it"
                                        : "Not holding it",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: classData.classStatus == 1
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is TodayClassesFailure) {
                  return Center(
                    child: Text("Error: ${state.failureMSG}"),
                  );
                }

                return const Center(
                  child: Text("Unexpected state."),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
