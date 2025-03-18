import 'dart:convert';

import 'package:aloka_mobile_app/src/services/api/main_api.dart';

import '../../models/tute/tute_model.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> insertTute(TuteModelClass tuteModelCLass) async {
  final url = Uri.parse('${API.tute}/insert_tute.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(tuteModelCLass.toJson()));

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

Future<Map<String, dynamic>> updateTute(TuteModelClass tuteModelCLass) async {
  final url = Uri.parse('${API.tute}/update_tute.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(tuteModelCLass.toJsonUpdate()));

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

Future<Map<String, dynamic>> getStudentTute(
    int studentId, int classCategoryHasStudentClassId) async {
  final url = Uri.parse('${API.tute}/get_student_tute.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "student_id": studentId,
        "class_category_has_student_class_id": classCategoryHasStudentClassId,
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

Future<Map<String, dynamic>> checkStudentTute(
    int studentId, int classCategoryHasStudentClassId, String tuteFor) async {
  final url = Uri.parse('${API.tute}/fetch_student_tute.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "student_id": studentId,
        "class_category_has_student_class_id": classCategoryHasStudentClassId,
        "tute_for": tuteFor,
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
