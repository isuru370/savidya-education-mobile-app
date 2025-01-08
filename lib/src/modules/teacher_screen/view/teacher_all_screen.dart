import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../components/slidable_details_view_widget.dart';
import '../../../res/color/app_color.dart';
import '../bloc/teacher_bloc/teacher_bloc.dart';

class TeacherAllScreen extends StatefulWidget {
  final bool editMode;
  const TeacherAllScreen({
    super.key,
    required this.editMode,
  });

  @override
  State<TeacherAllScreen> createState() => _TeacherAllScreenState();
}

class _TeacherAllScreenState extends State<TeacherAllScreen> {
  String searchQuery = '';
  String? dateOnly;

  @override
  void initState() {
    super.initState();
    context.read<TeacherBloc>().add(GetTeacherData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: ColorUtil.tealColor[10],
        title: const Text("Teacher"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
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
            // Expanded List of Teachers
            Expanded(
              child: BlocBuilder<TeacherBloc, TeacherState>(
                builder: (context, state) {
                  if (state is GetTeacherFailure) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  if (state is GetTeacherSuccess) {
                    final filteredList =
                        state.getActiveTeacherList.where((teacher) {
                      return teacher.teacherCusId!.contains(searchQuery) ||
                          teacher.fullName!.contains(searchQuery) ||
                          teacher.mobile!.contains(searchQuery) ||
                          teacher.nic!.contains(searchQuery);
                    }).toList();
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        convertDate(filteredList[index].createdAt!);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: SlidableDetailsViewWidget(
                            onTap: (cxt) {
                              if (widget.editMode) {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed('/teacher_screen', arguments: {
                                  "teacher_data": filteredList[index],
                                  "update_teacher": true,
                                });
                              } else {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed('/teacher_profile_screen',
                                        arguments: {
                                      "teacher_data": filteredList[index],
                                    });
                              }
                            },
                            circleWidget: CircleAvatar(
                              radius: 30,
                              child: Text(
                                filteredList[index].fullName!.substring(0, 1),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: ColorUtil.whiteColor[10],
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            contend: "${filteredList[index].teacherCusId}",
                            subContend: "${filteredList[index].initialName} "
                                " (${filteredList[index].graduationDetails})",
                            circleText: "${filteredList[index].fullName}",
                            joinDate: "Join Date $dateOnly",
                            icon: widget.editMode ? Icons.edit : Icons.report,
                          ),
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void convertDate(DateTime createAt) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    dateOnly = dateFormat.format(createAt);
  }
}
