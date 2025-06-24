import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class XanoService {
  static const String baseUrl = 'https://cooploto.xano.com/api:62c05b5091f242001a499832';
  static String get apiKey {
    if (kIsWeb) {
      throw UnsupportedError('Les variables d\'environnement ne sont pas supportées sur le web');
    }
    return Platform.environment['XANO_API_KEY'] ?? 'YOUR_XANO_API_KEY';
  }

  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user/login'),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': apiKey,
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print('Erreur lors de la connexion: $e');
      return false;
    }
  }

  Future<bool> register(String email, String password, String pseudo) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user/register'),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': apiKey,
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'pseudo': pseudo,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print('Erreur lors de l\'inscription: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> getUser(String email) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user?email=$email'),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': apiKey,
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      print('Erreur lors de la récupération de l\'utilisateur: $e');
      return null;
    }
  }
}
