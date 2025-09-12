import 'package:flutter/material.dart';
import 'package:health_tracker/core/extension/context.extensions.dart';
import 'package:health_tracker/core/theme/app_colors.dart';

class AppTextField extends StatefulWidget {
  final String? hint;
  final String? label;
  final String? errorText;
  final String? helperText;
  final TextEditingController controller;
  final bool isPassword;
  final Widget? suffix;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool isDisabled;
  final int? maxLines;
  const AppTextField({
    required this.controller,
    this.hint,
    this.label,
    this.helperText,
    this.errorText,
    this.isPassword = false,
    this.isDisabled = false,
    this.suffix,
    this.onChanged,
    this.validator,
    this.maxLines,
    super.key,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    bool checkIfPassword = widget.isPassword;
    return Column(
      children: [
        if (widget.label != null) ...[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                widget.label!,
                style: context.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
        TextFormField(
          enabled: !widget.isDisabled,
          style: widget.isDisabled
              ? context.bodyMedium?.copyWith(color: AppColors.textSecondary)
              : context.bodyMedium,
          obscureText: checkIfPassword ? isObscure : false,
          controller: widget.controller,
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscuringCharacter: '*',
          decoration: InputDecoration(
            hintText: widget.hint,
            contentPadding: const EdgeInsets.all(16),
            filled: true,
            fillColor: AppColors.textOnPrimary,
            hintStyle: context.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.textSecondary,
                width: 1.2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary, width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary, width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.error, width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            errorText: widget.errorText,
            helperText: widget.helperText,
            errorStyle: context.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: Colors.red,
            ),
            suffixIcon: widget.isPassword
                ? InkWell(
                    onTap: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    child: Icon(
                      isObscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.textSecondary,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [widget.suffix ?? Container(width: 1)],
                  ),
          ),
        ),
      ],
    );
  }
}

String? validateEmailTextFields(String? value) {
  if (value == null) return 'Email Field must not be empty';

  if (RegExp(
    r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{1,7}$',
  ).hasMatch(value)) {
    return null;
  } else {
    return 'Email is Invalid';
  }
}

String? validatePasswordTextFields(String? value) {
  if (value == null) return 'Password must not be empty';
  if (value.length < 6) return 'Password must be at least 6 characters long';
  return null;
}

String? validateRequiredField(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Field must not be empty';
  }
  return null;
}
