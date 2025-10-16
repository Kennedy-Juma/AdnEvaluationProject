import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthService with ChangeNotifier {
  String baseUrl = "https://10.0.2.2:7093/api/v1";
  final _storage = const FlutterSecureStorage();
  String? _token;
  String? userId;
  String? role;

  bool get isAuthenticated => _token != null;

  Future<void> setBaseUrl(String url) async {
    baseUrl = url;
  }

  //save access token/current session in local storage
  Future<void> saveToken(String token) async {
    _token = token;
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    await _storage.write(key: 'jwt_token', value: token);
    role = payload['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];
    userId = payload['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name'];
    notifyListeners();
  }

  //client logout---> temporary, complete token cleanup to be handled in api
  Future<void> logout() async {
    _token = null;
    role = null;
    userId = null;
    await _storage.delete(key: 'jwt_token');
    notifyListeners();
  }

  //autologin and token expriy
  Future<void> tryAutoLogin() async {
    final token = await _storage.read(key: 'jwt_token');
    if (token == null) return;
    if (Jwt.isExpired(token)) {
      await logout();
      return;
    }
    await saveToken(token);
  }

  //POST: api/v1/login
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final res = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': email, 'password': password}));
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      final token = body['token'];
      if (token == null) {
        throw Exception('No token returned from API');
      }
      await saveToken(token);
      return {'success': true};
    } else {
      final message = res.body;
      return {'success': false, 'message': message};
    }
  }

  //POST: api/v1/register
  Future<Map<String, dynamic>> signup(String firstName,String lastName,
      String email,
      String phoneNumber,
      String password) async {
    final url = Uri.parse('$baseUrl/auth/register');
    final res = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'firstName':firstName,'lastName':lastName,
          'email': email,'phoneNumber':phoneNumber, 'password': password}));
    if (res.statusCode == 201 || res.statusCode == 200) {
      return {'success': true};
    } else {
      return {'success': false, 'message': res.body};
    }
  }
}
