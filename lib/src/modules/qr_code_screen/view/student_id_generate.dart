import 'package:aloka_mobile_app/src/res/color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class StudentIdGenerate extends StatelessWidget {
  final int studentId;
  final String cusStudentId;
  final String? studentInitialName;

  const StudentIdGenerate({
    super.key,
    required this.studentId,
    required this.cusStudentId,
    this.studentInitialName,
  });

  Future<void> _generateAndSharePDF(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text(
                studentInitialName ?? "No Name",
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Container(
                child: pw.Center(
                  child: pw.BarcodeWidget(
                    data: cusStudentId,
                    barcode: pw.Barcode.qrCode(),
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                cusStudentId,
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.grey,
                ),
              ),
            ],
          );
        },
      ),
    );

    // Share or Preview PDF
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'Student_ID_$cusStudentId.pdf',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: ColorUtil.tealColor[10],
        automaticallyImplyLeading: false,
        title: const Text(
          'Generate Id',
          style: TextStyle(letterSpacing: 2),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _generateAndSharePDF(context);
            },
            icon: const Icon(Icons.share),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pushNamed('/home');
        },
        child: Text(
          'Home',
          style: TextStyle(color: ColorUtil.whiteColor[10]),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                studentInitialName ?? "No Name",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: QrImageView(
                  data: cusStudentId,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                cusStudentId,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: ColorUtil.blackColor[10]!,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      "Important",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorUtil.blackColor[10],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Each child is assigned a unique code that can only be used by that child. Also, all the details of the child can be obtained through this code. Make sure to safeguard it.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorUtil.blackColor[10],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
