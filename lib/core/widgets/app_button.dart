import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:health_tracker/core/extension/context.extensions.dart';
import 'package:health_tracker/core/theme/app_colors.dart';

enum ButtonLength { short, long }

enum ButtonType { filled, outlined, tonal }

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final String buttonText;
  final Color? buttonColor;
  final bool hasIcon;
  final IconData? icon;
  final Image? image;
  final bool isDisabled;
  final double? width;
  final ButtonLength? buttonLength;
  final ButtonType? buttonType;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.buttonText,
    this.onPressed,
    this.buttonColor,
    this.hasIcon = false,
    this.icon,
    this.isDisabled = false,
    this.width,
    this.image,
    this.buttonType = ButtonType.filled,
    this.buttonLength = ButtonLength.long,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: _getOnPressed(),
      height: 60,
      elevation: 0,
      highlightElevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
      disabledColor: _getDisabledColor(),
      minWidth: _getButtonWidth(),
      shape: _getButtonShape(),
      color: _getButtonColor(),
      child: _buildButtonContent(context),
    );
  }

  void Function()? _getOnPressed() {
    if (isDisabled || isLoading) return null;
    return onPressed ?? () {};
  }

  Color _getDisabledColor() {
    return buttonColor?.withAlpha(100) ?? AppColors.textPrimary.withAlpha(100);
  }

  double _getButtonWidth() {
    return width ?? (buttonLength == ButtonLength.long ? 335 : 220);
  }

  RoundedRectangleBorder _getButtonShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: buttonType == ButtonType.outlined
          ? BorderSide(
              color: buttonColor ?? AppColors.textPrimary.withAlpha(160),
            )
          : BorderSide.none,
    );
  }

  Color _getButtonColor() {
    return buttonType == ButtonType.filled
        ? buttonColor ?? AppColors.primary
        : Colors.transparent;
  }

  Widget _buildButtonContent(BuildContext context) {
    if (isLoading) {
      return _buildLoadingIndicator();
    }

    if (hasIcon) {
      return _buildButtonWithIcon(context);
    }

    return _buildButtonText(context);
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: SizedBox(
        width: 17,
        height: 17,
        child: CircularProgressIndicator(
          color: buttonColor ?? AppColors.textPrimary,
          strokeWidth: 2.5,
        ),
      ),
    );
  }

  Widget _buildButtonWithIcon(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (image != null)
          image!
        else
          Icon(icon, color: _getTextColor(), size: 15),
        const Gap(10),
        Text(buttonText, style: _getTextStyle(context)),
      ],
    );
  }

  Widget _buildButtonText(BuildContext context) {
    return Text(buttonText, style: _getTextStyle(context));
  }

  Color _getTextColor() {
    return buttonType == ButtonType.filled
        ? AppColors.surface
        : buttonColor ?? AppColors.textPrimary;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    return context.bodyMedium?.copyWith(
      color: _getTextColor(),
      fontWeight: FontWeight.w600,
    );
  }
}
