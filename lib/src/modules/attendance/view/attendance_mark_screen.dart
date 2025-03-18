import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:intl/intl.dart';
import '../../../models/qr_read/qr_read.dart';
import '../../../provider/cubit_provider/check_box_list_cubit/checkbox_button_cubit.dart';
import '../../../res/color/app_color.dart';
import '../../qr_code_screen/bloc/QRScanner/qr_scanner_bloc.dart';
import '../../tute/bloc/tute_bloc/tute_bloc.dart';

class AttendanceMarkScreen extends StatefulWidget {
  final List<QrReadStudentModelClass> studentList;
  final List<QrReadClassCatModelClass> classAttList;
  final List<QrReadStudentPaymentModel> paymentList;
  final int attendanceId;
  final String studentCusId;

  const AttendanceMarkScreen({
    super.key,
    required this.studentList,
    required this.classAttList,
    required this.paymentList,
    required this.attendanceId,
    required this.studentCusId,
  });

  @override
  State<AttendanceMarkScreen> createState() => _AttendanceMarkScreenState();
}

class _AttendanceMarkScreenState extends State<AttendanceMarkScreen> {
  bool checkAtt = false;
  bool checkPay = false;
  bool checkTute = false;
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    context.read<CheckboxButtonCubit>().toggleCheckPayStatus(false);
    context.read<CheckboxButtonCubit>().toggleCheckTuteStatus(false);
    final now = DateTime.now();
    final tuteFor = DateFormat("yyyy MMM").format(now);
    context.read<TuteBloc>().add(CheckStudentTuteEvent(
        studentId: widget.studentList[0].studentId!,
        classCategoryId: widget.studentList[0].classCategoryId!,
        tuteFor: tuteFor));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [_buildAttendanceBody(), _buildPaymentBody()],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: 100,
      backgroundColor: ColorUtil.tealColor[10],
      title: const Text(
        "Attendance",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildAttendanceBody() {
    return BlocListener<QrScannerBloc, QrScannerState>(
      listener: (context, state) {
        if (state is ReadAttendanceFailure) {
          _showSnackBar(state.failureMessage);
        } else if (state is MarkAttendanceSuccess) {
          _showSnackBar("Attendance data insertion is successful.");

          if (checkPay) {
            context.read<QrScannerBloc>().add(
                  StudentPaymentReadEvent(studentCustomId: widget.studentCusId),
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
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: widget.studentList.isNotEmpty
                ? _buildStudentCard()
                : const Text("No student data available."),
          );
        },
      ),
    );
  }

  void _navigateToPaymentScreen(PaymentReadSuccess state) {
    Navigator.of(context, rootNavigator: true).pushNamed(
      '/payment_screen',
      arguments: {
        "student_last_payment": state.studentLastPaymentList,
        "student_custom_id": widget.studentCusId,
      },
    );
  }

  Widget _buildStudentCard() {
    final student = widget.studentList[0];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  student.imageUrl!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.initialName!,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    _buildAttendanceCheckbox(),
                    BlocBuilder<TuteBloc, TuteState>(
                      builder: (context, state) {
                        if (state is TuteProcessState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is CheckTuteSuccessState) {
                          if (state.chackTute > 0) {
                            return const Text("Tute already given.");
                          } else {
                            return _buildTuteCheckbox();
                          }
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: 8),
                    student.studentClassFreeCard == 0
                        ? _buildPaymentCheckbox()
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (student.studentClassFreeCard == 1) _buildFreeCardBadge(),
          const SizedBox(height: 12),
          _buildActionButtons(),
        ],
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
              "Attendance",
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
              "Payment",
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFreeCardBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        "FreeCard",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorUtil.orangeColor[10],
          ),
          child: Text(
            'Back',
            style: TextStyle(color: ColorUtil.whiteColor[10]),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (checkAtt) {
              final attendanceData = QrReadStudentModelClass(
                classAttendanceId: widget.attendanceId,
                studentId: widget.studentList[0].studentId!,
                studentStudentClassId:
                    widget.studentList[0].studentStudentClassId,
                tuteFor: checkTute
                    ? DateFormat("yyyy MMM").format(DateTime.now())
                    : "",
                classCategoryId: widget.studentList[0].classHasCatId!,
              );
              context.read<QrScannerBloc>().add(MarkAttendanceEvent(
                    readAttendance: attendanceData,
                    message: studentMSG(
                      widget.studentList[0].initialName!,
                      widget.studentList[0].className!,
                      widget.studentList[0].categoryName!,
                    ),
                    studentMobileNumber: widget.studentList[0].guardianMobile!
                            .startsWith('0')
                        ? '94${widget.studentList[0].guardianMobile!.substring(1)}'
                        : widget.studentList[0].guardianMobile!,
                  ));
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorUtil.whiteColor[10],
          ),
          child: const Text('Mark'),
        ),
      ],
    );
  }

  Widget _buildPaymentBody() {
    if (widget.paymentList.isEmpty) {
      _announce("ගෙවීම් සම්බන්ධ විස්තර නොමැත.");
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text("No payment data available.",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      );
    }

    final latestPayment = widget.paymentList
        .reduce((a, b) => a.paymentDate!.isAfter(b.paymentDate!) ? a : b);
    final formattedAmount = NumberFormat.currency(
      locale: 'en_LK',
      symbol: 'LKR ',
      customPattern: '#,##0.00',
    ).format(widget.studentList[0].fees);

    _announce(
        "අවසාන ගෙවීම සිදු කර ඇත්තේ ${DateFormat('MMMM yyyy').format(latestPayment.paymentDate!)} මසදීය.");

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Student Last Payment Details",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 5,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text("Amount: $formattedAmount"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment Date: ${DateFormat('yyyy-MM-dd').format(latestPayment.paymentDate!)}",
                  ),
                  Text(
                    "Payment Time: ${DateFormat('HH:mm').format(latestPayment.paymentDate!)}",
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Month: ",
                      style: TextStyle(
                          fontSize: 16, color: ColorUtil.greenColor[10]),
                      children: [
                        WidgetSpan(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.teal[50], // Soft background color
                              borderRadius:
                                  BorderRadius.circular(8), // Rounded corners
                            ),
                            child: Text(
                              DateFormat('MMMM yyyy')
                                  .format(latestPayment.paymentDate!),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.teal[
                                    800], // Matching the app's theme color
                                fontSize: 14, // Slightly smaller and elegant
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              trailing: Icon(Icons.payment, color: ColorUtil.tealColor[10]),
            ),
          )
        ],
      ),
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
   String studentMSG(
      String studentName, String studentClass, String categoryName) {
    String formattedDate =
        DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.now());
    return "$studentName has been marked present in $studentClass ($categoryName) on $formattedDate.";
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }
}
