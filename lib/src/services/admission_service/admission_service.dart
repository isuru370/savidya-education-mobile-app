import 'dart:convert';

import '../../models/admission/admission_model_class.dart';
import '../../models/admission/admission_payment_model.dart';
import '../api/main_api.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> insertAdmissionData(
    AdmissionModelClass admissionModel) async {
  final url = Uri.parse('${API.admission}/add_admission.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(admissionModel.toJson()));

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

Future<Map<String, dynamic>> getAdmission() async {
  try {
    final response =
        await http.get(Uri.parse('${API.admission}/get_admission.php'));
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

//admission payment and student update admission
Future<Map<String, dynamic>> updateAdmissionData(
    AdmissionPaymentModelClass admissionPay) async {
  final url = Uri.parse('${API.admission}/update_admission.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(admissionPay.toJson()));

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

Future<Map<String, dynamic>> todayGetAdmissionPayment() async {
  try {
    final response = await http
        .get(Uri.parse('${API.admission}/get_today_paid_admission.php'));
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
