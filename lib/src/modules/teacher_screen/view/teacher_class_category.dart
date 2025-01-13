import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // Import the intl package

import '../../../res/color/app_color.dart';
import '../bloc/teacher_class_category/teacher_class_category_bloc.dart';

class TeacherClassCategory extends StatefulWidget {
  final int teacherClassId;
  final String gradeName;
  final String teacherName;
  final String className;

  const TeacherClassCategory({
    super.key,
    required this.teacherClassId,
    required this.gradeName,
    required this.teacherName,
    required this.className,
  });

  @override
  State<TeacherClassCategory> createState() => _TeacherClassCategoryState();
}

class _TeacherClassCategoryState extends State<TeacherClassCategory> {
  final _currencyFormat = NumberFormat.currency(
      locale: "en_LK", symbol: "LKR"); // Sri Lankan currency format

  @override
  void initState() {
    super.initState();
    context.read<TeacherClassCategoryBloc>().add(
        GetTeacherClassCategoryEvent(teacherClassId: widget.teacherClassId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: ColorUtil.tealColor[10],
        elevation: 5,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Grade : ${widget.gradeName}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                ' ${widget.className}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Teacher: ${widget.teacherName}',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/home');
          },
          child: const Text("Home")),
      body: BlocConsumer<TeacherClassCategoryBloc, TeacherClassCategoryState>(
        listener: (context, state) {
          if (state is TeacherClassCategoryFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failureMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is TeacherClassCategoryProcess) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TeacherClassCategorySuccess) {
            if (state.teacherClassCategoryModel.isEmpty) {
              return const Center(child: Text('No categories available.'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.teacherClassCategoryModel.length,
              itemBuilder: (context, index) {
                final category = state.teacherClassCategoryModel[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category.categoryName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Fees: ${_currencyFormat.format(category.classFees)}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Created: ${category.createdAt.toLocal().toShortDate()}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    '/payment_monthly_report_screen',
                                    arguments: {
                                      'class_category_has_student_class_id':
                                          category.classHasCatId,
                                      'garde_name': widget.gradeName,
                                      'class_name': widget.className,
                                      'category_name': category.categoryName,
                                    });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorUtil.tealColor[10],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'View Payment',
                                style:
                                    TextStyle(color: ColorUtil.whiteColor[10]),
                              ),
                            ),
                            const SizedBox(width: 8), // Spacing between buttons
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    '/teacher_student_report_screen',
                                    arguments: {
                                      'class_id': widget.teacherClassId,
                                      'class_has_cat_id':
                                          category.classHasCatId,
                                      'grade_name': widget.gradeName,
                                      'teacher_name': widget.teacherName,
                                      'class_name': widget.className,
                                    });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorUtil.tealColor[10],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'View Student',
                                style:
                                    TextStyle(color: ColorUtil.whiteColor[10]),
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
          } else if (state is TeacherClassCategoryFailure) {
            return Center(
              child: Text(
                'Error: ${state.failureMessage}',
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }

          return const Center(child: Text('No data available.'));
        },
      ),
    );
  }
}

extension DateFormat on DateTime {
  String toShortDate() {
    return "$day/$month/$year";
  }
}
