import 'dart:convert';

import '../api/main_api.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getBankDetails() async {
  try {
    final response = await http.get(Uri.parse('${API.bank}/get_bank_data.php'));
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

Future<Map<String, dynamic>> getBranchDetails(int bankId) async {
  final url = Uri.parse('${API.bank}/get_branch_details.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"bank_id": bankId}));

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
