import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static const String baseUrl =
      "https://verifyrealestateandservices.in/Second%20PHP%20FILE/e-commerce";

  // ✅ SIGNUP with file upload
  static Future<Map<String, dynamic>> registerUser({
    required String name,
    required String number,
    required String email,
    required String address,
    required String password,
    required String profile_Image,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("$baseUrl/insert_user.php"),
      );

      request.fields['name'] = name;
      request.fields['number'] = number;
      request.fields['email'] = email;
      request.fields['address'] = address;
      request.fields['password'] = password;

      if (profile_Image.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'profile_image',
            profile_Image,
          ),
        );
      }

      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        print(responseData);
        return jsonDecode(responseData);
      } else {
        throw Exception("Failed to register user");
      }
    } catch (e) {
      print("Signup Error: $e");
      throw Exception(e.toString());
    }
  }

  // ✅ LOGIN
  static Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/login.php"),
        body: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        print("Login Response: ${response.body}");
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to login");
      }
    } catch (e) {
      print("Login Error: $e");
      throw Exception(e.toString());
    }
  }
}