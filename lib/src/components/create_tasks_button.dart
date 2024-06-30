import 'package:flutter/material.dart';

import '../values/colors.dart';

class CreateTasksButton extends StatelessWidget {
  final String? data;
  final bool selected;
  final VoidCallback onPressed;

  const CreateTasksButton({
    super.key,
    this.data,
    this.selected = false,
    required this.onPressed,
  });

  static const Size size = Size(82, 112);

  @override
  Widget build(BuildContext context) {
    final selectedBorder = Border.all(
      width: 2,
      color: AppColors.selectedBorderColor,
    );

    return InkWell(
      onTap: onPressed,
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
            visible: data != null,
            child: Text(
              data ?? '',
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
