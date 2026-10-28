import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/app_user.dart';
import '../theme/app_colors.dart';

/// In-memory auth until a real backend is wired up. Seeded with the demo
/// account shown on the login screen.
class AuthController extends GetxController {
  static const demoEmail = 'demo@nimbus.app';
  static const demoPassword = 'demo1234';

  final Map<String, AppUser> _users = {
    demoEmail: const AppUser(
      name: 'Demo',
      email: demoEmail,
      password: demoPassword,
    ),
  };

  final RxnString currentUserName = RxnString();

  static String? validateName(String value) =>
      value.trim().length < 2 ? 'Name must be at least 2 characters.' : null;

  static String? validateEmail(String value) =>
      RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim())
      ? null
      : 'Enter a valid email.';

  static String? validatePassword(String value) =>
      value.length < 8 ? 'Password must be at least 8 characters.' : null;

  logIn(String email, String password) {
    // final user = _users[email.trim().toLowerCase()];
    // if (user == null || user.password != password) return false;
    // currentUserName.value = user.name;
    // return true;
  }

  /// Returns false when the email is already registered.
  bool signUp(String name, String email, String password) {
    final key = email.trim().toLowerCase();
    if (_users.containsKey(key)) return false;
    _users[key] = AppUser(name: name.trim(), email: key, password: password);
    currentUserName.value = name.trim();
    return true;
  }

  void showMessage(String message) {
    Get.snackbar(
      '',
      message,
      titleText: const SizedBox.shrink(),
      backgroundColor: AppColors.navy,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
