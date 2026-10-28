import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nimbus_weather_app/controllers/auth_controller_new.dart';
// import 'package:flutter_nimbus_weather_app_samicontrollers/auth_controller_new.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'widgets/app_text_field.dart';
import 'widgets/logo_badge.dart';
import 'widgets/primary_button.dart';
import '../controllers/auth_controller.dart';
import 'signup_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final loginController = Get.put(AuthControllerNew());

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    loginController.login(_email.text, _password.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(24.w, 56.h, 24.w, 36.h),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - 92.h,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LogoBadge(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 28.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Welcome back', style: AppTextStyles.heading),
                          SizedBox(height: 8.h),
                          Text(
                            'Log in to see weather for the cities you care about.',
                            style: AppTextStyles.subheading,
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextField(
                            label: 'Email',
                            hint: 'you@example.com',
                            controller: _email,
                            validator: (v) =>
                                AuthController.validateEmail(v ?? ''),
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'\s')),
                              LengthLimitingTextInputFormatter(254),
                            ],
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 16.h),
                          AppTextField(
                            label: 'Password',
                            hint: 'Enter your password',
                            controller: _password,
                            validator: (v) => (v ?? '').isEmpty
                                ? 'Enter your password.'
                                : null,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(64),
                            ],
                            isPassword: true,
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => _submit(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(14.r),
                      decoration: BoxDecoration(
                        color: AppColors.hintBackground,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Text(
                        'Demo account: ${AuthController.demoEmail} / ${AuthController.demoPassword}',
                        style: AppTextStyles.demoHint,
                      ),
                    ),
                    Obx(() {
                      return Column(
                        children: [
                          SizedBox(height: 24.h),
                          loginController.isLoading.value
                              ? Center(child: CircularProgressIndicator())
                              : PrimaryButton(
                                  label: 'Log in',
                                  onPressed: _submit,
                                ),
                        ],
                      );
                    }),

                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(top: 24.h),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 6.w,
                        children: [
                          Text('New to Nimbus?', style: AppTextStyles.footer),
                          GestureDetector(
                            onTap: () => Get.off(() => const SignupView()),
                            child: Text(
                              'Create account',
                              style: AppTextStyles.footerLink,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
