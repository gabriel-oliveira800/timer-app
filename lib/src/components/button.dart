import 'package:flutter/material.dart';
import 'package:timer_app/src/values/colors.dart';

class Button extends StatelessWidget {
  final String text;
  final double? width;
  final bool isLoading;
  final EdgeInsets? padding;
  final VoidCallback? onPressed;

  const Button({
    super.key,
    this.width,
    this.padding,
    this.onPressed,
    this.text = 'Iniciar',
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final childSize = Size(width ?? double.infinity, 54.0);
    final isEnable = onPressed != null;

    return Padding(
      padding: padding ?? const EdgeInsets.all(24.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          maximumSize: childSize,
          minimumSize: childSize,
          backgroundColor: AppColors.swatch_01,
          disabledBackgroundColor: AppColors.darkColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Visibility(
          visible: !isLoading,
          replacement: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              strokeWidth: 1,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: isEnable ? AppColors.white : AppColors.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
