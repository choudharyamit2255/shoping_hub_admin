import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shoping_hub_admin/auth/models/user_admin.dart';
import 'package:shoping_hub_admin/core/api_endpoint.dart';



class AuthService {
  Future<String> login(UserAdmin user) async {
    String url = ApiEndpoint.LoginUrl;
    String strUser = jsonEncode(user.toMap());
    final response = await http.post(
      Uri.parse(url),
      body: strUser,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final map = jsonDecode(response.body);
      return map['token'];
    } else {
      throw "Inccorect Username password";
    }
  }

  Future<String> signUp(UserAdmin user) async {
    String url = ApiEndpoint.signUpUrl;
    String strUser = jsonEncode(user.toMap());
    final response = await http.post(
      Uri.parse(url),
      body: strUser,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      return "Account Created Successfully";
    } else {
      throw ("Unable to create account");
    }
  }Future<void> logout()async{

  }
}