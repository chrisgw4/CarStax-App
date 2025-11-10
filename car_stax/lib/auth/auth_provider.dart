import 'dart:async';
import 'dart:io';
import 'package:car_stax/auth/auth.dart';
import 'package:car_stax/backend/backend_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_riverpod/legacy.dart';

enum AuthState { unknown, authenticated, unauthenticated }

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repo;

  AuthNotifier(this._repo) : super(AuthState.unknown) {
    _init();
  }

  Future<void> _init() async {
    final cookie = await _repo.getCookie();
    if (cookie != null && cookie.isNotEmpty) {
      state = AuthState.authenticated;

      // Set the cookies to be used for functions in the backend
      sessionCookie = cookie;
      parsedCookie = Cookie.fromSetCookieValue(sessionCookie!);

    } else {
      state = AuthState.unauthenticated;
    }
  }

  Future<void> login(String email, String password) async {
    final result = await _repo.login(email, password);
    if (result['success'] == true) {
      state = AuthState.authenticated;
    } else {
      state = AuthState.unauthenticated;
    }
  }

  Future<void> logout() async {
    await _repo.logout();
    state = AuthState.unauthenticated;
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier(AuthRepository()));
