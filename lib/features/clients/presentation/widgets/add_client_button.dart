import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';

class AddClientButton extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final String button_title;
  final double radius;
  final Widget? child;
  final Function() onPressed;
  // ignore: non_constant_identifier_names
  const AddClientButton({
    super.key,
    // ignore: non_constant_identifier_names
    required this.button_title,
    required this.radius,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark =
        Theme.of(context).brightness == Brightness.dark ? true : false;
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.primaryColor),
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
                      : AppColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
