import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../../models/camera/quick_image_model.dart';
import '../api/main_api.dart';

Future<Map<String, dynamic>> uploadImage(
    File? imageFilePath, QuickImageModel quickImageModel) async {
  final uri = Uri.parse("${API.studentImage}/quick_image.php");
  final request = http.MultipartRequest('POST', uri);

  if (imageFilePath != null) {
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFilePath.path));
  }

  var response = await request.send();

  if (response.statusCode == 200) {
    var responseData = await response.stream.bytesToString();
    try {
      var jsonResponse = jsonDecode(responseData) as Map<String, dynamic>;
      return jsonResponse;
    } catch (e) {
      return {'success': false, 'message': 'Invalid JSON response: $e'};
    }
  } else {
    return {
      'success': false,
      'message': 'File upload failed with status code ${response.statusCode}'
    };
  }
}

Future<Map<String, dynamic>> uploadImageData(
    QuickImageModel quickImageModel) async {
  final url = Uri.parse('${API.studentImage}/quick_image_data.php');

  final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(quickImageModel.toJson()));

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

Future<Map<String, dynamic>> getAllQuickImage() async {
  final response = await http
      .get(Uri.parse("${API.studentImage}/get_all_quick_image_data.php"));

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

Future<Map<String, dynamic>> uploadServerImage(File? imageFilePath) async {
  final uri = Uri.parse(API.serverUploadImage);
  final request = http.MultipartRequest('POST', uri);

  if (imageFilePath != null) {
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFilePath.path));
  }

  var response = await request.send();

  if (response.statusCode == 200) {
    var responseData = await response.stream.bytesToString();
    try {
      var jsonResponse = jsonDecode(responseData) as Map<String, dynamic>;
      return jsonResponse;
    } catch (e) {
      return {'success': false, 'message': 'Invalid JSON response: $e'};
    }
  } else {
    return {
      'success': false,
      'message': 'File upload failed with status code ${response.statusCode}'
    };
  }
}
