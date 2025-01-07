import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/user/user_model.dart';
import '../api/main_api.dart';

Future<Map<String, dynamic>> loginUser(MyUserModelClass myUser) async {
  final url = Uri.parse('${API.user}/user_login.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(myUser.userLoginToJson()));

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

Future<Map<String, dynamic>> insertUserData(MyUserModelClass myUser) async {
  final url = Uri.parse('${API.user}/system_user_create.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(myUser.toJson()));

  //================= check php error =================================
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
