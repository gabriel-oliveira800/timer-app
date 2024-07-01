import 'package:flutter/material.dart';

import '../values/colors.dart';

class RoundedButton extends StatelessWidget {
  final Size size;
  final String? text;
  final bool selected;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;

  const RoundedButton({
    super.key,
    this.text,
    this.onLongPress,
    this.selected = false,
    required this.onPressed,
    this.size = const Size(82, 112),
  });

  @override
  Widget build(BuildContext context) {
    final selectedBorder = Border.all(
      width: 2,
      color: AppColors.selectedBorderColor,
    );

    return InkWell(
      onTap: onPressed,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          border: selected ? selectedBorder : null,
          borderRadius: BorderRadius.circular(12),
          color: selected ? AppColors.selectedBgColor : AppColors.darkColor,
        ),
        child: Center(
          child: Visibility(
            replacement: const Icon(
              Icons.add,
              size: 32,
              color: AppColors.white,
            ),
            visible: text != null,
            child: Text(
              text ?? '',
              style: TextStyle(
                fontSize: 14,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                color: selected ? AppColors.selectedTextColor : AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
