import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/qr_read/qr_read.dart';
import '../api/main_api.dart';

Future<Map<String, dynamic>> searchStudentAttendance(
    QrReadStudentModelClass studentRead) async {
  final url = Uri.parse('${API.attendance}/read_attendance.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(studentRead.toJson()));

  // ================= check php error =================================
  // log("Response status: ${response.statusCode}");
  // log("Response body: ${response.body}");

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    return responseData;
  } else {
    return {
      "success": false,
      "message": "server Error",
    };
  }
}

Future<Map<String, dynamic>> markStudentAttendance(
    QrReadStudentModelClass studentRead) async {
  final url = Uri.parse('${API.attendance}/attendance.php');

  final response = await http.post(
    url,
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode(studentRead.markJson()),
  );

  // Uncomment for debugging
  // log("Response status: ${response.statusCode}");
  // log("Response body: ${response.body}");

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    return responseData;
  } else {
    return {
      "success": false,
      "message": "server Error",
    };
  }
}

Future<Map<String, dynamic>> searchStudentPayment(
    String studentCustomId) async {
  final url = Uri.parse('${API.payment}/read_payment_student.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"studentCustomId": studentCustomId}));

  // ================= check php error =================================
  // log("Response status: ${response.statusCode}");
  // log("Response body: ${response.body}");

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    return responseData;
  } else {
    return {
      "success": false,
      "message": response,
    };
  }
}
