import 'dart:convert';
import 'package:http/http.dart' as http;

import '../api/main_api.dart';

Future<Map<String, dynamic>> emailVerify(String userName) async {
  final url = Uri.parse(API.passwordForgot);

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"username": userName}));

  // Log the response for debugging purposes
  // log("Response status: ${response.statusCode}");
  // log("Response body: ${response.body}");

  if (response.statusCode == 200) {
    // Parse the response body
    final responseData = jsonDecode(response.body);
    return {"success": true, "message": responseData};
  } else if (response.statusCode == 500) {
    // Handle internal server error
    return {
      "success": false,
      "message": "User Not Found",
    };
  } else {
    // Handle other status codes if needed
    return {
      "success": false,
      "message": "Unexpected error occurred",
    };
  }
}

Future<Map<String, dynamic>> passwordReset(
    String userName, int otp, String password) async {
  final url = Uri.parse(API.passwordReset);

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "name": userName,
        "code": otp,
        "password": password,
        "repassword": password
      }));

  // Log the response for debugging purposes
  // log("Response status: ${response.statusCode}");
  // log("Response body: ${response.body}");

  if (response.statusCode == 200) {
    // Parse the response body
    final responseData = jsonDecode(response.body);
    return {"success": true, "message": responseData};
  } else if (response.statusCode == 500) {
    // Handle internal server error
    return {
      "success": false,
      "message": "Code expired or invalid",
    };
  } else {
    // Handle other status codes if needed
    return {
      "success": false,
      "message": "Unexpected error occurred",
    };
  }
}
