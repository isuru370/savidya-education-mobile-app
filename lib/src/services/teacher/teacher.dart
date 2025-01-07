import 'dart:convert';

import 'package:aloka_mobile_app/src/models/teacher/teacher.dart';

import '../../models/class_schedule/class_schedule.dart';
import '../api/main_api.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getActiveTeacher() async {
  try {
    final response =
        await http.get(Uri.parse('${API.teacher}/get_all_active_teacher.php'));
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData;
    } else {
      return {
        "success": false,
        "message": "Server error",
      };
    }
  } catch (e) {
    return {
      "success": false,
      "message": e.toString(),
    };
  }
}

Future<Map<String, dynamic>> insertTeacherData(
    TeacherModelClass teacherModelClass) async {
  final url = Uri.parse('${API.teacher}/insert_teacher_data.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(teacherModelClass.toJson()));

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

Future<Map<String, dynamic>> updateTeacherData(
    TeacherModelClass teacherModelClass) async {
  final url = Uri.parse('${API.teacher}/teacher_update.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(teacherModelClass.toUpdateJson()));

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

Future<Map<String, dynamic>> teacherPercentage(
    ClassScheduleModelClass teacherPre) async {
  final url = Uri.parse('${API.teacher}/teacher_percentage.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(teacherPre.toPercentageJson()));

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

Future<Map<String, dynamic>> teacherClassCategory(int teacherClassId) async {
  final url = Uri.parse('${API.teacher}/teacher_class_category.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "teacher_class_id": teacherClassId,
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
