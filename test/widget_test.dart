import 'package:flutter_test/flutter_test.dart';
import 'package:nimbus_weather_app/controllers/auth_controller.dart';

// import 'package:flutter_nimbus_weather_app_samicontrollers/auth_controller.dart';

void main() {
  group('AuthController validation', () {
    test('name needs at least 2 characters', () {
      expect(
        AuthController.validateName('A'),
        'Name must be at least 2 characters.',
      );
      expect(AuthController.validateName('Sara'), isNull);
    });

    test('email must look valid', () {
      expect(AuthController.validateEmail('sara@'), 'Enter a valid email.');
      expect(AuthController.validateEmail('sara@example.com'), isNull);
    });

    test('password needs at least 8 characters', () {
      expect(
        AuthController.validatePassword('12345'),
        'Password must be at least 8 characters.',
      );
      expect(AuthController.validatePassword('12345678'), isNull);
    });
  });

  group('AuthController accounts', () {
    test('demo account logs in, wrong password does not', () {
      final auth = AuthController();
      expect(
        auth.logIn(AuthController.demoEmail, AuthController.demoPassword),
        isTrue,
      );
      expect(auth.logIn(AuthController.demoEmail, 'nope'), isFalse);
    });

    test('sign up rejects a duplicate email', () {
      final auth = AuthController();
      expect(auth.signUp('Sara', 'sara@example.com', 'password1'), isTrue);
      expect(auth.signUp('Sara', 'SARA@example.com', 'password1'), isFalse);
      expect(auth.logIn('sara@example.com', 'password1'), isTrue);
    });
  });
}
