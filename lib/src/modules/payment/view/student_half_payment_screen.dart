import 'package:flutter/material.dart';

import '../../../models/payment_model_class/last_payment_model_class.dart';
import '../components/build_student_half_list_widget.dart';
import '../components/build_student_info_widget.dart';

class StudentHalfPaymentScreen extends StatefulWidget {
  final List<LastPaymentModelClass> studentLastPaymentList;
  final String studentCustomId;

  const StudentHalfPaymentScreen({
    super.key,
    required this.studentLastPaymentList,
    required this.studentCustomId,
  });

  @override
  State<StudentHalfPaymentScreen> createState() =>
      _StudentHalfPaymentScreenState();
}

class _StudentHalfPaymentScreenState extends State<StudentHalfPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Half Payment Screen'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          _buildStudentInfo(),
          const SizedBox(height: 16),
          Expanded(child: _buildStudentList()),
        ],
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/home');
          },
          child: const Text('Home')),
    );
  }

  Widget _buildStudentInfo() {
    final student = widget.studentLastPaymentList.isNotEmpty
        ? widget.studentLastPaymentList[0]
        : null;

    return BuildStudentInfoWidget(
      imageUrl: student?.imageUrl ?? '',
      initialName: student?.initialName ?? 'No Name Available',
      studentCustomId: widget.studentCustomId,
    );
  }

  Widget _buildStudentList() {
    return ListView.builder(
      itemCount: widget.studentLastPaymentList.length,
      itemBuilder: (context, index) {
        final student = widget.studentLastPaymentList[index];
        return _buildStudentListItem(student);
      },
    );
  }

  Widget _buildStudentListItem(LastPaymentModelClass student) {
    return BuildStudentHalfListWidget(
      className: student.className,
      categoryName: student.categoryName,
      gradeName: student.gradeName,
      studentFreeCard: student.classFreeCard,
      onPayPressed: () {
        _showValidationPopup(student);
      },
    );
  }

  void _showValidationPopup(LastPaymentModelClass student) {
    TextEditingController _inputController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Validation Required"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Please enter the required code to proceed."),
              const SizedBox(height: 10),
              TextField(
                controller: _inputController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter validation code",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_inputController.text == "Tharanga7454") {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.of(context).pushNamed(
                    '/student_half_payment_update_screen',
                    arguments: {
                      "student_id": int.parse(student.studentId),
                      "class_has_cat_id": int.parse(student.classHasCategory),
                      "custom_id": widget.studentCustomId,
                    },
                  );
                } else {
                  Navigator.of(context).pop(); // Close the dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text("Incorrect validation code. Please try again."),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }
}
