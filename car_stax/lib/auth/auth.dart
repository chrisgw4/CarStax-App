import 'dart:convert';

import 'package:car_stax/backend/backend_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  final _storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await backend_login(email, password);

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['success'] == true) {
      // Save cookie (if using cookie-based auth)
      final cookie = response.headers['set-cookie'];
      if (cookie != null) {
        await _storage.write(key: 'cookie', value: cookie);
      }
    }

    return data;
  }

  Future<void> logout() async {
    final cookie = await _storage.read(key: 'cookie');
    final response = await backend_logout(cookie);

    if (response.statusCode == 200) {
      await _storage.delete(key: 'cookie');
    }
  }

  Future<String?> getCookie() async => await _storage.read(key: 'cookie');
}