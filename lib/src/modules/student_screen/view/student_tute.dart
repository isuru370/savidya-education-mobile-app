import 'package:aloka_mobile_app/src/modules/tute/bloc/tute_bloc/tute_bloc.dart';
import 'package:aloka_mobile_app/src/res/color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/tute/tute_model.dart';

class StudentTute extends StatefulWidget {
  final int studentId;
  final int classCategoryHasStudentClassId;
  const StudentTute(
      {super.key,
      required this.studentId,
      required this.classCategoryHasStudentClassId});

  @override
  State<StudentTute> createState() => _StudentTuteState();
}

class _StudentTuteState extends State<StudentTute> {
  @override
  void initState() {
    super.initState();
    context.read<TuteBloc>().add(ClassCategoryTuteEvent(
        studentId: widget.studentId,
        classCategoryId: widget.classCategoryHasStudentClassId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tute'),
        backgroundColor: ColorUtil.tealColor[10],
      ),
      body: BlocBuilder<TuteBloc, TuteState>(
        builder: (context, state) {
          if (state is TuteProcessState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetStudentTuteSuccessState) {
            return ListView.builder(
              itemCount: state.tuteModelClass.length,
              itemBuilder: (context, index) {
                final TuteModelClass tuteData = state.tuteModelClass[index];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal[300],
                        child: const Icon(Icons.book, color: Colors.white),
                      ),
                      title: Row(
                        children: [
                          const Icon(Icons.school,
                              color: Colors.blueAccent, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            tuteData.className ?? "No Class Name",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.article,
                                  color: Colors.orangeAccent, size: 18),
                              const SizedBox(width: 6),
                              Text(tuteData.tuteFor ?? "No Tute Info"),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today,
                                  color: Colors.redAccent, size: 18),
                              const SizedBox(width: 6),
                              Text(
                                tuteData.createAt != null
                                    ? "${tuteData.createAt!.day}-${tuteData.createAt!.month}-${tuteData.createAt!.year}"
                                    : "No Date",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is TuteFailureState) {
            return Center(child: Text(state.failureMessage));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
