import 'dart:convert';

import '../../models/class_attendance/class_attendance.dart';
import '../api/main_api.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> classAttendanceInsert(
    ClassAttendanceModelClass classAttendanceModelClass) async {
  final url = Uri.parse('${API.classAttendance}/class_attendance.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(classAttendanceModelClass.toJson()));

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

Future<Map<String, dynamic>> getClassAttendance(int classCatId) async {
  final url = Uri.parse('${API.classAttendance}/get_class_attendance.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"classCatId": classCatId}));

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

Future<Map<String, dynamic>> reScheduleClass(
    ClassAttendanceModelClass classAttendanceModelClass) async {
  final url = Uri.parse('${API.classAttendance}/re_schedule_class.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(classAttendanceModelClass.reScheduleJson()));

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

Future<Map<String, dynamic>> getTodayClasses(String selectDate) async {
  final url = Uri.parse('${API.classAttendance}/get_today_classes.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"class_date": selectDate}));

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
