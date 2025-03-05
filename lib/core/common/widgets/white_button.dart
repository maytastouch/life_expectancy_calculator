import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class WhiteButton extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final String button_title;
  final double radius;
  final Widget? child;
  final Function() onPressed;
  // ignore: non_constant_identifier_names
  const WhiteButton({
    super.key,
    // ignore: non_constant_identifier_names
    required this.button_title,
    required this.radius,
    required this.onPressed,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark =
        Theme.of(context).brightness == Brightness.dark ? true : false;
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: AppColors.primaryColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
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
                color: isDark ? AppColors.whiteColor : AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
