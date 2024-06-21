import 'package:flutter/material.dart';

import '../../../../../core/common/widgets/text_widget.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/utils.dart';

class AddContactTextField extends StatelessWidget {
  final String? label;
  final String hint;
  final int? maxLine;
  final int? minLine;
  final TextEditingController controller;
  final bool enableValidation;
  final IconButton? trailingIcon; // Add this line
  final bool readOnly;
  final Function? onTap;

  const AddContactTextField({
    super.key,
    this.label,
    required this.hint,
    this.maxLine = 1,
    this.minLine = 1,
    required this.controller,
    this.enableValidation = true,
    this.trailingIcon,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark =
        Theme.of(context).brightness == Brightness.dark ? true : false;
    final utils = Utils(context);
    Color color = utils.color;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: label ?? "",
          color: color,
          textSize: AppConstants.mainFont4,
          hoverColor: color,
          isTitle: true,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width *
              0.35, // Adjust the width as needed
          child: TextFormField(
            onTap: onTap as void Function()?,
            readOnly: readOnly,
            controller: controller,
            maxLines: maxLine,
            minLines: minLine,
            style: TextStyle(
              color: isDark ? AppColors.whiteColor : AppColors.blackColor,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              suffixIcon: trailingIcon, // Add this line
            ),
            validator: enableValidation
                ? (value) {
                    if (value!.isEmpty) {
                      return "$hint is missing!";
                    }
                    return null;
                  }
                : null,
          ),
        ),
      ],
    );
  }
}
