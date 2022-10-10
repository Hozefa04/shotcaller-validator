import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomLoader extends StatelessWidget {
  final double? size;
  const CustomLoader({
    Key? key,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: const CircularProgressIndicator(
          color: AppColors.primaryColor
        ),
      ),
    );
  }
}
