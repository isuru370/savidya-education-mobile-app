import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

Future<void> checkUserRegistration(String email) async {
  final url = Uri.parse(
      'http://192.168.1.6/Aloka-Mobile-App-Backend/api/user/check_registration.php');

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      'email': email,
    }),
  );

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    log(responseData['message']);
  } else {
    log('Failed to check registration status.');
  }
}
