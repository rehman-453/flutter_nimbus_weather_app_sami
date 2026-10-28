import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nimbus_weather_app/controllers/auth_controller_new.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'widgets/app_text_field.dart';
import 'widgets/logo_badge.dart';
import 'widgets/primary_button.dart';
import '../controllers/auth_controller.dart';
import 'login_view.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _auth = Get.find<AuthController>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final registerController = Get.put(AuthControllerNew());

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    registerController.register(_name.text, _email.text, _password.text);

    // if (_auth.signUp(_name.text, _email.text, _password.text)) {
    //   _auth.showMessage(
    //     'Account created. Welcome, ${_auth.currentUserName.value}!',
    //   );
    // } else {
    //   _auth.showMessage('An account with this email already exists.');
    // }
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
                          Text(
                            'Create your account',
                            style: AppTextStyles.heading,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Save cities and notes, and sync them on every device.',
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
                            label: 'Full name',
                            hint: 'Your name',
                            controller: _name,
                            validator: (v) =>
                                AuthController.validateName(v ?? ''),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r"[\p{L}\s'.\-]", unicode: true),
                              ),
                              LengthLimitingTextInputFormatter(50),
                            ],
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 16.h),
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
                            hint: 'At least 8 characters',
                            controller: _password,
                            validator: (v) =>
                                AuthController.validatePassword(v ?? ''),
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
                    SizedBox(height: 24.h),
                    PrimaryButton(label: 'Create account', onPressed: _submit),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(top: 24.h),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 6.w,
                        children: [
                          Text(
                            'Already have an account?',
                            style: AppTextStyles.footer,
                          ),
                          GestureDetector(
                            onTap: () => Get.off(() => const LoginView()),
                            child: Text(
                              'Log in',
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
