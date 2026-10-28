import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

/// Labeled text field matching the Nimbus design. Meant to live inside a
/// [Form]: pass a [validator] and the error shows under the field; use
/// [inputFormatters] to restrict what can be typed. Set [isPassword] for the
/// show/hide toggle.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.inputFormatters,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border(Color color, double width) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(color: color, width: width),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: AppTextStyles.label),
        SizedBox(height: 8.h),
        TextFormField(
          validator: widget.validator,
          inputFormatters: widget.inputFormatters,
          controller: widget.controller,
          obscureText: widget.isPassword && _obscured,
          keyboardType: widget.keyboardType,
          textCapitalization: widget.textCapitalization,
          textInputAction: widget.textInputAction,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          style: AppTextStyles.input,
          cursorColor: AppColors.primary,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: AppTextStyles.inputHint,
            filled: true,
            fillColor: Colors.white,
            constraints: BoxConstraints(minHeight: 52.h),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            errorStyle: AppTextStyles.errorText,
            errorMaxLines: 2,
            border: border(AppColors.border, 1),
            enabledBorder: border(AppColors.border, 1),
            focusedBorder: border(AppColors.primary, 1.5),
            errorBorder: border(AppColors.error, 1.5),
            focusedErrorBorder: border(AppColors.error, 1.5),
            suffixIcon: widget.isPassword
                ? GestureDetector(
                    onTap: () => setState(() => _obscured = !_obscured),
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: SvgPicture.asset(
                        _obscured
                            ? 'assets/icons/eye.svg'
                            : 'assets/icons/eye_off.svg',
                        width: 22.w,
                        height: 22.w,
                      ),
                    ),
                  )
                : null,
            suffixIconConstraints: BoxConstraints(
              minHeight: 22.w,
              minWidth: 22.w,
            ),
          ),
        ),
      ],
    );
  }
}
