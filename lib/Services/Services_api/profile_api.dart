import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../View_Models/Profile_model.dart';

class ProfileApi {
  static const String baseUrl =
      'https://verifyrealestateandservices.in/Second%20PHP%20FILE/e-commerce';

  static const String endpoint = '/show_users.php';

  // ✅ Single user fetch करो
  static Future<profilemodel> fetchUserProfile() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print('API Response: $jsonData');
        return profilemodel.fromJson(jsonData);
      } else {
        throw Exception('Failed to load profile: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet Connection');
    }
  }

  // ✅ Multiple users fetch करो (अगर चाहिए)
  static Future<List<profilemodel>> fetchUsersList() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        // अगर response एक list है
        if (jsonData is List) {
          return (jsonData).map((x) => profilemodel.fromJson(x)).toList();
        }
        // अगर response एक object है जिसमें 'data' array है
        else if (jsonData['data'] is List) {
          return List<profilemodel>.from(
            jsonData['data'].map((x) => profilemodel.fromJson(x)),
          );
        }
        throw Exception('Invalid response format');
      } else {
        throw Exception('Failed to load data');
      }
    } on SocketException {
      throw Exception('No Internet Connection');
    }
  }
}