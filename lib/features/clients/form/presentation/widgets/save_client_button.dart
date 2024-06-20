import 'package:flutter/material.dart';

import '../../../../../../core/constants/colors.dart';

class SaveClientButton extends StatelessWidget {
  final String button_title;
  final double radius;
  final Widget? child;
  final Function() onPressed;
  final bool isRed;

  const SaveClientButton({
    super.key,
    // ignore: non_constant_identifier_names
    required this.button_title,
    required this.radius,
    required this.child,
    required this.onPressed,
    this.isRed = false,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark =
        Theme.of(context).brightness == Brightness.dark ? true : false;
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.primaryColor),
        backgroundColor: isRed ? Colors.red : null, // Add this line
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (child != null) child!,
            Text(
              button_title,
              style: TextStyle(
                  color: isDark
                      ? AppColors.whiteModeColor
                      : isRed
                          ? AppColors.whiteColor
                          : AppColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
