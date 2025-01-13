import 'dart:convert';

import '../../models/attendance/attendance.dart';
import '../../models/attendance/class_student_attendance_mode.dart';
import '../api/main_api.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> insertStudentData(
    StudentAttendanceModelClass studentAttendance) async {
  final url = Uri.parse('${API.attendance}/attendance.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(studentAttendance.toJson()));

  // ================= check php error =================================
  // log("Response status: ${response.statusCode}");
  // log("Response body: ${response.body}");

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    return {"success": true, "message": responseData};
  } else if (response.statusCode == 409) {
    return {
      "success": false,
      "message": "attendance already mark",
    };
  } else {
    return {
      "success": false,
      "message": "Server error",
    };
  }
}

Future<Map<String, dynamic>> getStudentUniqueAttendance(
    int studentId, int classCatStudentClassId) async {
  final url = Uri.parse('${API.attendance}/get_student_attendance.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "studentId": studentId,
        "class_category_has_student_class_id": classCatStudentClassId
      }));

  // ================= check php error =================================
  // log("Response status: ${response.statusCode}");
  // log("Response body: ${response.body}");

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    return responseData;
  } else {
    return {
      "success": false,
      "message": "Server error",
    };
  }
}

Future<Map<String, dynamic>> getAttendanceCount(
    String date, int studentStudentClassId, int studentId) async {
  final url = Uri.parse('${API.attendance}/attendance_count.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "attendanceDate": date,
        "studentStudentStudentClassId": studentStudentClassId,
        "studentId": studentId,
      }));

  // ================= check php error =================================
  // log("Response status: ${response.statusCode}");
  // log("Response body: ${response.body}");

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    return responseData;
  } else {
    return {
      "success": false,
      "message": "Server error",
    };
  }
}

Future<Map<String, dynamic>> updateStudentAttendance(int classAttendanceId,
    String atDate, int studentId, int studentHasClassId) async {
  final url = Uri.parse('${API.attendance}/student_attendance_update.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "at_date": atDate,
        "student_student_student_class_id": studentHasClassId,
        "student_id": studentId,
        "class_attendance_id" : classAttendanceId,
      }));

  // ================= check php error =================================
  // log("Response status: ${response.statusCode}");
  // log("Response body: ${response.body}");

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    return responseData;
  } else {
    return {
      "success": false,
      "message": "Server error",
    };
  }
}

Future<Map<String, dynamic>> classStudentAttendance(
    ClassStudentAttendanceMode modelClassStudentAttendance) async {
  final url = Uri.parse('${API.attendance}/student_class_attendance.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(modelClassStudentAttendance.toJson()));

  // ================= check php error =================================
  // log("Response status: ${response.statusCode}");
  // log("Response body: ${response.body}");

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    return responseData;
  } else {
    return {
      "success": false,
      "message": "Server error",
    };
  }
}

Future<Map<String, dynamic>> newAttendanceRead(
  String studentCusId,
) async {
  final url = Uri.parse('${API.attendance}/new_attendance_read.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "student_cus_id": studentCusId,
      }));

  // ================= check php error =================================
  // log("Response status: ${response.statusCode}");
  // log("Response body: ${response.body}");

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    return responseData;
  } else {
    return {
      "success": false,
      "message": "Server error",
    };
  }
}
