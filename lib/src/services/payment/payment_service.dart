import 'dart:convert';


import '../../models/payment_model_class/payment_model_class.dart';
import '../../models/payment_model_class/student_half_payment_model.dart';
import '../api/main_api.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> studentPaymentInsert(
    PaymentModelClass paymentModelClass) async {
  final url = Uri.parse('${API.payment}/payments.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(paymentModelClass.toJson()));

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

Future<Map<String, dynamic>> sendPaymentMessage(
    String msg, String number) async {
  final url = Uri.parse('${API.payment}/send-sms');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"message": msg, "mobile": number}));

  // ================= check php error =================================
  // log("Response status: ${response.statusCode}");
  // log("Response body: ${response.body}");

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    return {
      "success": true,
      "sms": responseData,
    };
  } else {
    return {
      "success": false,
      "message": "Server error",
    };
  }
}

Future<Map<String, dynamic>> getUniqueStudentPayment(
    int studentId, int classCategoryHasStudentClassId) async {
  final url = Uri.parse('${API.payment}/student_unique_payment.php');

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

Future<Map<String, dynamic>> monthlyPaymentReport(
    String paymentMonth, int classCategoryHasStudentClassId) async {
  final url = Uri.parse('${API.payment}/payment_monthly_report.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "payment_month": paymentMonth,
        "student_has_category_id": classCategoryHasStudentClassId,
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

Future<Map<String, dynamic>> studentHalfPayment(int studentId,
    int classCategoryHasStudentClassId, String paymentMonth) async {
  final url = Uri.parse('${API.payment}/student_half_payment_update.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "student_id": studentId,
        "class_has_cat_id": classCategoryHasStudentClassId,
        "payment_month": paymentMonth,
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

Future<Map<String, dynamic>> studentPaymentUpdate(
    StudentHalfPaymentModel studentHalfPayModel) async {
  final url = Uri.parse('${API.payment}/payment_update.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(studentHalfPayModel.halfPaymentUpdate()));

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

Future<Map<String, dynamic>> studentPaymentDelete(int paymentId) async {
  final url = Uri.parse('${API.payment}/student_payment_delete.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "payment_id": paymentId,
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
