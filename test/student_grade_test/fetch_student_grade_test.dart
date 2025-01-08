import 'dart:convert';
import 'package:aloka_mobile_app/src/services/api/main_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_student_grade_test.mocks.dart';

// Mock the HTTP client
@GenerateMocks([http.Client]) // This generates the mock class
void main() {
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
  });

  group('getGrade', () {
    test('returns data when the server responds with a 200 status code',
        () async {
      // Arrange: Mock the response
      const response = '{"success": true, "grades": "A"}';
      when(mockClient.get(Uri.parse('${API.student}/grade.php')))
          .thenAnswer((_) async => http.Response(response, 200));

      // Act: Call the method
      final result = await getGrade(mockClient);

      // Assert: Check that the result matches the expected data
      expect(result['success'], true);
      expect(result['grades'], 'A');
    });

    test('returns error message when the server responds with an error',
        () async {
      // Arrange: Mock the response
      when(mockClient.get(Uri.parse('${API.student}/grade.php')))
          .thenAnswer((_) async => http.Response('Error', 500));

      // Act: Call the method
      final result = await getGrade(mockClient);

      // Assert: Check that the result is an error message
      expect(result['success'], false);
      expect(result['message'], 'Server error');
    });

    test('returns error when the request fails', () async {
      // Arrange: Simulate an exception
      when(mockClient.get(Uri.parse('${API.student}/grade.php')))
          .thenThrow(Exception('Network error'));

      // Act: Call the method
      final result = await getGrade(mockClient);

      // Assert: Check that the result is an error message
      expect(result['success'], false);
      expect(result['message'], 'Exception: Network error');
    });
  });
}

// Modify the getGrade function to accept an HTTP client
Future<Map<String, dynamic>> getGrade(http.Client client) async {
  try {
    final response = await client.get(
        Uri.parse('${API.student}/grade.php')); // Ensure consistent URL here
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
