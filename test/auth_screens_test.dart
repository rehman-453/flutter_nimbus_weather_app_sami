import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nimbus_weather_app/controllers/auth_controller.dart';
import 'package:nimbus_weather_app/views/login_view.dart';
import 'package:nimbus_weather_app/views/signup_view.dart';

// import 'package:flutter_nimbus_weather_app_samicontrollers/auth_controller.dart';
// import 'package:flutter_nimbus_weather_app_samiviews/login_view.dart';
// import 'package:flutter_nimbus_weather_app_samiviews/signup_view.dart';

Widget _host(Widget child) => ScreenUtilInit(
  designSize: const Size(390, 844),
  builder: (_, _) => GetMaterialApp(home: child),
);

void main() {
  setUp(() {
    GoogleFonts.config.allowRuntimeFetching = false;
    Get.testMode = true;
    Get.put(AuthController());
  });
  tearDown(Get.reset);

  testWidgets('signup shows validation errors from the design', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_host(const SignupView()));
    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 'A');
    await tester.enterText(fields.at(1), 'sara@');
    await tester.enterText(fields.at(2), '12345');
    await tester.tap(find.text('Create account').first);
    await tester.pump();

    expect(find.text('Name must be at least 2 characters.'), findsOneWidget);
    expect(find.text('Enter a valid email.'), findsOneWidget);
    expect(
      find.text('Password must be at least 8 characters.'),
      findsOneWidget,
    );

    await tester.enterText(fields.at(0), 'Sara');
    await tester.pump();
    expect(find.text('Name must be at least 2 characters.'), findsNothing);
  });

  testWidgets('login flags an empty form', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_host(const LoginView()));
    await tester.tap(find.text('Log in').first);
    await tester.pump();

    expect(find.text('Enter a valid email.'), findsOneWidget);
    expect(find.text('Enter your password.'), findsOneWidget);
  });

  testWidgets('signup input formatters filter what can be typed', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_host(const SignupView()));
    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), "Sara 3 O'Neil-Smith");
    await tester.enterText(fields.at(1), 'sa ra@exam ple.com');
    await tester.enterText(fields.at(2), 'a' * 80);

    String text(int i) =>
        tester.widget<TextField>(fields.at(i)).controller!.text;
    expect(text(0), "Sara  O'Neil-Smith");
    expect(text(1), 'sara@example.com');
    expect(text(2).length, 64);
  });
}
