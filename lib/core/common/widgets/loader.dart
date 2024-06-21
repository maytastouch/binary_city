import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 10,
        width: 10,
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
