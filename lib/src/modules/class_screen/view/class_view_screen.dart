import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aloka_mobile_app/src/modules/class_screen/bloc/class_bloc/class_bloc_bloc.dart';
import 'package:aloka_mobile_app/src/res/color/app_color.dart';

class ClassScheduleScreen extends StatefulWidget {
  const ClassScheduleScreen({super.key});

  @override
  State<ClassScheduleScreen> createState() => _ClassScheduleScreenState();
}

class _ClassScheduleScreenState extends State<ClassScheduleScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ClassBlocBloc>().add(GetOngoingClass());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text("Class Schedule",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: ColorUtil.tealColor[10],
        centerTitle: true,
      ),
      body: BlocBuilder<ClassBlocBloc, ClassBlocState>(
        builder: (context, state) {
          if (state is ClassDataProcess) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetOngoingSuccess) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: state.studentModelClass.length,
                itemBuilder: (context, index) {
                  final classItem = state.studentModelClass[index];
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
                                  '${classItem.className!} '
                                  ' Grade ${classItem.gradeName!} '
                                  ' ${classItem.subjectName!} ',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Teacher: ${classItem.teacherInitialName!}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Subject: ${classItem.subjectName!}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed('/schedule_view', arguments: {
                                'class_id': classItem.id,
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
                              'view Class',
                              style: TextStyle(color: ColorUtil.whiteColor[10]),
                            ),
                          ),
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
                "Data not found",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
        },
      ),
    );
  }
}
