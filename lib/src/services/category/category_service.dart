import 'dart:convert';

import '../api/main_api.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getClassCategory() async {
  try {
    final response =
        await http.get(Uri.parse('${API.classCategory}/category.php'));
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
