import 'dart:convert';

import '../../models/class_schedule/class_schedule.dart';
import '../api/main_api.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> insertClassData(
    ClassScheduleModelClass classModelClass) async {
  final url = Uri.parse('${API.studentClass}/insert_class.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(classModelClass.toJson()));

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

Future<Map<String, dynamic>> updateClassData(
    ClassScheduleModelClass classModelClass) async {
  final url = Uri.parse('${API.studentClass}/update_class.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(classModelClass.toUpdateJson()));

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

Future<Map<String, dynamic>> getActiveClass() async {
  try {
    final response =
        await http.get(Uri.parse('${API.studentClass}/get_active_class.php'));
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

Future<Map<String, dynamic>> getInactiveClass() async {
  try {
    final response =
        await http.get(Uri.parse('${API.studentClass}/get_inactive_class.php'));
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

Future<Map<String, dynamic>> getAllClass() async {
  try {
    final response =
        await http.get(Uri.parse('${API.studentClass}/get_all_class.php'));
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

Future<Map<String, dynamic>> getOngoingClass() async {
  try {
    final response = await http.get(
        Uri.parse('${API.studentClass}/class_active_and_onging_class.php'));
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

Future<Map<String, dynamic>> getHall() async {
  try {
    final response =
        await http.get(Uri.parse('${API.studentClass}/get_class_hall.php'));
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
