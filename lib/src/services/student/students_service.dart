import 'dart:convert';

import 'package:aloka_mobile_app/src/models/student/student.dart';

import '../api/main_api.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> insertStudentData(
    StudentModelClass studentModelClass) async {
  final url = Uri.parse('${API.student}/students.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(studentModelClass.studentModelClassInsertDataJson()));

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

Future<Map<String, dynamic>> updateStudentData(
    StudentModelClass studentModelClass) async {
  final url = Uri.parse('${API.student}/student_update.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(studentModelClass.toUpdateStudentJson()));

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

Future<Map<String, dynamic>> getActiveStudent() async {
  try {
    final response =
        await http.get(Uri.parse('${API.student}/get_all_active_student.php'));
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

Future<Map<String, dynamic>> getUniqueStudent(String studentCusId) async {
  final url = Uri.parse('${API.student}/get_unique_student.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"custom_id": studentCusId}));

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

Future<Map<String, dynamic>> getInactiveStudent() async {
  try {
    final response = await http
        .get(Uri.parse('${API.student}/get_all_inactive_student.php'));
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

Future<Map<String, dynamic>> getAllStudent() async {
  try {
    final response =
        await http.get(Uri.parse('${API.student}/get_all_student.php'));
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

Future<Map<String, dynamic>> studentAddClass(
    StudentModelClass studentModelClass) async {
  final url = Uri.parse('${API.student}/student_add_class.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(studentModelClass.studentAddClassToJson()));

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

Future<Map<String, dynamic>> studentPercentage(
    int studentId, int classCategoryHasStudentClassId) async {
  final url = Uri.parse('${API.attendance}/student_percentage.php');

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

Future<Map<String, dynamic>> getAllStudentHasClass() async {
  try {
    final response = await http
        .get(Uri.parse('${API.student}/get_all_student_has_class_data.php'));
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

Future<Map<String, dynamic>> studentInTheClass(
    int studentClassId, int classHasCatId) async {
  final url =
      Uri.parse('${API.student}/student_in_the_class.php'); // Correct URL

  final response = await http.post(
    url,
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode({
      "student_class_id": studentClassId,
      "class_has_cat_id": classHasCatId
    }),
  );

  // Log the response status and body for debugging
  // log("Response status: ${response.statusCode}");
  // log("Response body: ${response.body}");

  if (response.statusCode == 200) {
    try {
      final responseData = jsonDecode(response.body);
      return responseData;
    } catch (e) {
      return {
        "success": false,
        "message": "Failed to parse JSON response",
      };
    }
  } else {
    return {
      "success": false,
      "message": "Server error: ${response.statusCode}",
    };
  }
}
