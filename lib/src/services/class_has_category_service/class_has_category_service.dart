import 'dart:convert';

import '../../models/category_has_class/category_has_class.dart';
import '../api/main_api.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> insertClassCategory(
    CategoryHasClassModelClass categoryHasCategory) async {
  final url =
      Uri.parse('${API.classHasCategory}/insert_class_has_category.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(categoryHasCategory.toJson()));

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

Future<Map<String, dynamic>> getClassHasCategory() async {
  try {
    final response = await http
        .get(Uri.parse('${API.classHasCategory}/get_class_has_category.php'));
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

Future<Map<String, dynamic>> getAllTheoryAnRevision() async {
  try {
    final response = await http
        .get(Uri.parse('${API.classHasCategory}/get_all_cat_and_class.php'));
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

Future<Map<String, dynamic>> getUniqueClassCategory(int classId) async {
  final url = Uri.parse('${API.classHasCategory}/get_unique_class_has_cat.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"classId": classId}));

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
