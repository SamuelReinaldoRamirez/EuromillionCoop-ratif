import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class XanoService {
  // static const String baseUrl = 'https://cooploto.xano.com/api:62c05b5091f242001a499832';
  static const String baseUrl = 'https://x8ki-letl-twmt.n7.xano.io/api:y8YLSaQk';
  // static String get apiKey {
  //   if (kIsWeb) {
  //     throw UnsupportedError('Les variables d\'environnement ne sont pas supportées sur le web');
  //   }
  //   return Platform.environment['XANO_API_KEY'] ?? 'YOUR_XANO_API_KEY';
  // }

  // static String get apiKey {
  //   if (kIsWeb) {
  //     throw UnsupportedError('Les variables d\'environnement ne sont pas supportées sur le web');
  //   }
  //   final key = dotenv.env['XANO_ACCESS_TOKEN'];
  //   if (key == null || key.isEmpty) {
  //     throw Exception('XANO_ACCESS_TOKEN non défini dans .env');
  //   }
  //   return key;
  // }

  static String get loginKey {
    if (kIsWeb) {
      throw UnsupportedError('Les variables d\'environnement ne sont pas supportées sur le web');
    }
    final key = dotenv.env['XANO_LOGIN'];
    if (key == null || key.isEmpty) {
      throw Exception('XANO_LOGIN non défini dans .env');
    }
    return key;
  }


  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': loginKey,
        },
        body: jsonEncode({
          "email": email,
          "pwd": password,
        }),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return {
          'success': true,
          'statusCode': 200,
          'authToken': body['authToken'],
          'body': body,
        };
      } else {
        return {
          'success': false,
          'statusCode': response.statusCode,
          'message': 'Erreur lors de la connexion',
          'body': response.body,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Exception lors de la connexion',
        'error': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> register(String email, String password, [String? pseudo]) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "email": email,
          "pwd": password,
          if (pseudo != null) "pseudo": pseudo,
        }),
      );

      final body = jsonDecode(response.body);

      return {
        'success': response.statusCode == 200 || response.statusCode == 201,
        'statusCode': response.statusCode,
        'body': body,
      };
    } catch (e) {
      return {
        'success': false,
        'statusCode': -1,
        'error': e.toString(),
      };
    }
  }

  // Future<Map<String, dynamic>?> getUser(String email) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('$baseUrl/user?email=$email'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'x-api-key': apiKey,
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       return jsonDecode(response.body);
  //     }
  //     return null;
  //   } catch (e) {
  //     print('Erreur lors de la récupération de l\'utilisateur: $e');
  //     return null;
  //   }
  // }
}
