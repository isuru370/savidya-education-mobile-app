import 'package:aloka_mobile_app/src/models/attendance/new_attendance_read_model.dart';
import 'package:aloka_mobile_app/src/modules/payment/components/build_student_info_widget.dart';
import 'package:aloka_mobile_app/src/res/color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:intl/intl.dart';

import '../../../models/qr_read/qr_read.dart';
import '../../../provider/cubit_provider/check_box_list_cubit/checkbox_button_cubit.dart';
import '../../qr_code_screen/bloc/QRScanner/qr_scanner_bloc.dart';
import '../../tute/bloc/tute_bloc/tute_bloc.dart';

class NewAttendanceMarkScreen extends StatefulWidget {
  final List<NewAttendanceReadModel> newAttendanceReadModel;

  const NewAttendanceMarkScreen(
      {super.key, required this.newAttendanceReadModel});

  @override
  State<NewAttendanceMarkScreen> createState() =>
      _NewAttendanceMarkScreenState();
}

class _NewAttendanceMarkScreenState extends State<NewAttendanceMarkScreen> {
  bool checkAtt = false;
  bool checkPay = false;
  bool checkTute = false;
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    context.read<CheckboxButtonCubit>().toggleCheckPayStatus(false);
    context.read<CheckboxButtonCubit>().toggleCheckTuteStatus(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _buildBackButton(),
      body: BlocListener<QrScannerBloc, QrScannerState>(
        listener: (context, state) {
          if (state is ReadAttendanceFailure) {
            _showSnackBar(state.failureMessage);
          } else if (state is MarkAttendanceSuccess) {
            _showSnackBar("Attendance data insertion is successful.");

            if (checkPay) {
              context.read<QrScannerBloc>().add(
                    StudentPaymentReadEvent(
                        studentCustomId:
                            widget.newAttendanceReadModel[0].cusId),
                  );
            } else {
              Navigator.of(context).pop();
            }
          } else if (state is PaymentReadSuccess) {
            _navigateToPaymentScreen(state);
          }
        },
        child: BlocBuilder<QrScannerBloc, QrScannerState>(
          builder: (context, state) {
            if (state is AttendanceProcess) {
              return const Center(child: CircularProgressIndicator());
            }
            return _buildBody();
          },
        ),
      ),
    );
  }

  // AppBar Widget
  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: 100,
      title: const Text(
        "Attendance Mark",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
      backgroundColor: ColorUtil.tealColor[10],
    );
  }

  // Back Button
  Widget _buildBackButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text("Back"),
    );
  }

  // Body content of the screen
  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildStudentInfoCard(),
          _buildAttendanceList(),
        ],
      ),
    );
  }

  // Card for the student's general info
  Widget _buildStudentInfoCard() {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BuildStudentInfoWidget(
          imageUrl: widget.newAttendanceReadModel[0].imgUrl,
          initialName: widget.newAttendanceReadModel[0].initialName,
          studentCustomId: widget.newAttendanceReadModel[0].cusId,
        ),
      ),
    );
  }

  // List of student attendance and payment data
  Widget _buildAttendanceList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.newAttendanceReadModel.length,
      itemBuilder: (context, index) {
        final studentData = widget.newAttendanceReadModel[index];
        if (studentData.classAttendanceId != 0) {
          final now = DateTime.now();
          final tuteFor = DateFormat("yyyy MMM").format(now);
          context.read<TuteBloc>().add(CheckStudentTuteEvent(
                studentId: studentData.studentId,
                classCategoryId: studentData.classCatId!,
                tuteFor: tuteFor,
              ));
        }
        return _buildAttendanceCard(studentData);
      },
    );
  }

  // Attendance Card for each student
  Widget _buildAttendanceCard(NewAttendanceReadModel studentData) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextRow("Class: ${studentData.className ?? 'N/A'}"),
            _buildTextRow("Subject: ${studentData.subjectName ?? 'N/A'}"),
            _buildTextRow("Category: ${studentData.categoryName ?? 'N/A'}"),
            _buildTextRow("Grade: ${studentData.gradeName ?? 'N/A'}"),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                studentData.classAttendanceId != 0
                    ? _buildAttendanceCheckbox()
                    : const SizedBox.shrink(),
                studentData.classAttendanceId != 0
                    ? BlocBuilder<TuteBloc, TuteState>(
                        builder: (context, state) {
                          if (state is TuteProcessState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is CheckTuteSuccessState) {
                            if (state.chackTute > 0) {
                              return _buildGiveTuteCheckbox();
                            } else {
                              return _buildTuteCheckbox();
                            }
                          }
                          return const SizedBox.shrink();
                        },
                      )
                    : const SizedBox.shrink(),
                const SizedBox(width: 6),
                studentData.classAttendanceId != 0
                    ? studentData.isFreeCard == 0
                        ? _buildPaymentCheckbox()
                        : const SizedBox()
                    : const SizedBox.shrink(),
              ],
            ),
            const SizedBox(height: 10),
            _buildMarkButton(studentData),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
            _buildLastPaymentInfo(studentData),
          ],
        ),
      ),
    );
  }

  // Text Row for displaying class, subject, etc.
  Widget _buildTextRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildAttendanceCheckbox() {
    return BlocBuilder<CheckboxButtonCubit, CheckboxButtonState>(
      builder: (context, attendance) {
        checkAtt = attendance is CheckboxButtonInitial
            ? attendance.isPayHasAttStatus
            : false;
        return Row(
          children: [
            Transform.scale(
              scale: 1.3,
              child: Checkbox(
                semanticLabel: "Att",
                activeColor: ColorUtil.tealColor[800],
                checkColor: Colors.white,
                value: checkAtt,
                onChanged: (check) {
                  context
                      .read<CheckboxButtonCubit>()
                      .togglePayHasAttStatus(check!);
                },
              ),
            ),
            const Text(
              "Att",
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTuteCheckbox() {
    return BlocBuilder<CheckboxButtonCubit, CheckboxButtonState>(
      builder: (context, tute) {
        checkTute =
            tute is CheckboxButtonInitial ? tute.isCheckTuteStatus : false;
        return Row(
          children: [
            Transform.scale(
              scale: 1.3,
              child: Checkbox(
                semanticLabel: "Tute",
                activeColor: ColorUtil.tealColor[800],
                checkColor: Colors.white,
                value: checkTute,
                onChanged: (check) {
                  context
                      .read<CheckboxButtonCubit>()
                      .toggleCheckTuteStatus(check!);
                },
              ),
            ),
            const Text(
              "Tute",
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPaymentCheckbox() {
    return BlocBuilder<CheckboxButtonCubit, CheckboxButtonState>(
      builder: (context, payment) {
        checkPay =
            payment is CheckboxButtonInitial ? payment.isCheckPayStatus : false;
        return Row(
          children: [
            Transform.scale(
              scale: 1.3,
              child: Checkbox(
                semanticLabel: "Pay",
                activeColor: ColorUtil.tealColor[800],
                checkColor: Colors.white,
                value: checkPay,
                onChanged: (check) {
                  context
                      .read<CheckboxButtonCubit>()
                      .toggleCheckPayStatus(check!);
                },
              ),
            ),
            const Text(
              "Pay",
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      },
    );
  }

  // Checkbox and label for Attendance, Payment, Titute

  // Mark Button
  Widget _buildMarkButton(NewAttendanceReadModel studentData) {
    if (studentData.classAttendanceId != 0) {
      if (studentData.lastPaymentFor != null) {
        _announce(
            "${studentData.subjectName} ට අවසාන ගෙවීම සිදු කර ඇත්තේ ${studentData.lastPaymentFor!} මසදීය.");
      } else {
        _announce("ගෙවීම් සම්බන්ධ විස්තර නොමැත.");
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        studentData.classAttendanceId != 0
            ? ElevatedButton(
                onPressed: () {
                  if (checkAtt) {
                    final attendanceData = QrReadStudentModelClass(
                      classAttendanceId: studentData.classAttendanceId,
                      studentId: studentData.studentId,
                      studentStudentClassId: studentData.studentStudentClassId,
                      tuteFor: checkTute
                          ? DateFormat("yyyy MMM").format(DateTime.now())
                          : "",
                      classCategoryId: studentData.classCatId,
                    );
                    context.read<QrScannerBloc>().add(MarkAttendanceEvent(
                          readAttendance: attendanceData,
                          message: studentMSG(
                            studentData.initialName,
                            studentData.className!,
                            studentData.categoryName!,
                          ),
                          studentMobileNumber: studentData.guardianMobile
                                  .startsWith('0')
                              ? '94${studentData.guardianMobile.substring(1)}'
                              : studentData.guardianMobile,
                        ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorUtil.tealColor[10],
                ),
                child: const Text(
                  'Mark',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget _buildGiveTuteCheckbox() {
    return Row(
      children: [
        Icon(
          Icons.check_box,
          color: ColorUtil.tealColor[800],
        ),
        const Text(
          "Tute",
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  // Last Payment Info Card
  Widget _buildLastPaymentInfo(NewAttendanceReadModel studentData) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Student Last Payment Info",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            studentData.lastPaymentDate != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date: ${DateFormat('yyyy-MM-dd').format(studentData.lastPaymentDate!)}",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        "Time: ${DateFormat('HH:mm').format(studentData.lastPaymentDate!)}",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        "For: ${studentData.lastPaymentFor!}",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        "Amount: ${NumberFormat('#,###').format(studentData.amount!)}.00 LKR",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  )
                : const Text(
                    "No Payment Info",
                    style: TextStyle(color: Colors.grey),
                  ),
          ],
        ),
      ),
    );
  }

  void _navigateToPaymentScreen(PaymentReadSuccess state) {
    Navigator.of(context, rootNavigator: true).pushNamed(
      '/payment_screen',
      arguments: {
        "student_last_payment": state.studentLastPaymentList,
        "student_custom_id": widget.newAttendanceReadModel[0].cusId,
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _announce(String message) async {
    await _flutterTts.setLanguage("si-LK");
    await _flutterTts.speak(message);
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  String studentMSG(
      String studentName, String studentClass, String categoryName) {
    String formattedDate =
        DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.now());
    return "$studentName has been marked present in $studentClass ($categoryName) on $formattedDate.";
  }
}
