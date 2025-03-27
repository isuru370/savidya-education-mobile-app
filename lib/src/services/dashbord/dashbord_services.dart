import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api/main_api.dart';

Future<Map<String, dynamic>> getReport() async {
  try {
    final response =
        await http.get(Uri.parse('${API.dashbord}/count.php'));
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

Future<Map<String, dynamic>> getPaymentReport() async {
  try {
    final response =
        await http.get(Uri.parse('${API.dashbord}/payment_total.php'));
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

Future<Map<String, dynamic>> getPaymentChartReport() async {
  try {
    final response =
        await http.get(Uri.parse('${API.dashbord}/payment_line_chart.php'));
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
