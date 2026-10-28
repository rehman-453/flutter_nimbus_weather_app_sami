import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nimbus_weather_app/views/login_view.dart';
// import 'package:flutter_nimbus_weather_app_samiviews/login_view.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 6),
  )..repeat();
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Future.delayed(Duration(seconds: 2),(){
    //   Get.to(()=> LoginView());
    // });
    _timer = Timer(
      const Duration(milliseconds: 2500),
      () => Get.to(() => LoginView()),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200.w,
              height: 200.w,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (_, _) =>
                    CustomPaint(painter: _SunCloudPainter(_controller.value)),
              ),
            ),
            SizedBox(height: 10.h),
            Text('Nimbus', style: AppTextStyles.splashTitle),
            SizedBox(height: 10.h),
            Text('Weather & city guide', style: AppTextStyles.splashSubtitle),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.only(top: 24.h),
              child: Text(
                'Checking your session…',
                style: AppTextStyles.splashCaption,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Stand-in for the design's "loader-sun-cloud-dark" GIF: a rotating sun with
/// a drifting cloud.
class _SunCloudPainter extends CustomPainter {
  _SunCloudPainter(this.t);

  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 200;
    final sunCenter = Offset(88 * s, 88 * s);

    final sunPaint = Paint()..color = const Color(0xFFFFC53D);
    canvas.drawCircle(sunCenter, 30 * s, sunPaint);

    final ray = Paint()
      ..color = const Color(0xFFFFC53D)
      ..strokeWidth = 5 * s
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < 8; i++) {
      final a = t * 2 * math.pi + i * math.pi / 4;
      final dir = Offset(math.cos(a), math.sin(a));
      canvas.drawLine(sunCenter + dir * 44 * s, sunCenter + dir * 58 * s, ray);
    }

    final dx = math.sin(t * 2 * math.pi) * 6 * s;
    final cloud = Paint()..color = const Color(0xFFE8EFFF);
    canvas.save();
    canvas.translate(dx, 0);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(70 * s, 128 * s, 84 * s, 30 * s),
        Radius.circular(15 * s),
      ),
      cloud,
    );
    canvas.drawCircle(Offset(96 * s, 126 * s), 20 * s, cloud);
    canvas.drawCircle(Offset(124 * s, 120 * s), 25 * s, cloud);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_SunCloudPainter old) => old.t != t;
}
