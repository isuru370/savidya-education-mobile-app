import 'dart:convert';

import 'package:aloka_mobile_app/src/models/permission_model/permission_model.dart';

import '../api/main_api.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getPages() async {
  try {
    final response = await http.get(Uri.parse('${API.pages}/get_pages.php'));
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
  } catch (e) {
    return {
      "success": false,
      "message": e.toString(),
    };
  }
}

Future<Map<String, dynamic>> permissionResult(
    PermissionModel permissionModel) async {
  final url = Uri.parse('${API.permission}/permission.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(permissionModel.toJson()));

  //================= check php error =================================
  //log("Response status: ${response.statusCode}");
  //log("Response body: ${response.body}");

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
