import 'dart:convert';

import '../../models/student_has_category_has_class/student_has_category_has_class_model.dart';
import '../api/main_api.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getUniqueStudentClass(int studentId) async {
  final url = Uri.parse('${API.student}/student_has_class.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"studentId": studentId}));

  // ================= check php error =================================
  // log("Response status: ${response.statusCode}");
  // log("Response body: ${response.body}");

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    print(responseData);
    return responseData;
  } else {
    return {
      "success": false,
      "message": "Server error",
    };
  }
}

Future<Map<String, dynamic>> changeClass(
    StudentHasCategoryHasClassModelClass studentModelClass) async {
  final url = Uri.parse('${API.student}/student_class_update.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(studentModelClass.changeJson()));

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

Future<Map<String, dynamic>> deleteClass(
    StudentHasCategoryHasClassModelClass studentModelClass) async {
  final url = Uri.parse('${API.student}/student_class_delete.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(studentModelClass.deleteJson()));

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
