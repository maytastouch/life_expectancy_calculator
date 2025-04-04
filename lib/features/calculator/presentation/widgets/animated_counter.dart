import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';

class AnimatedCounter extends StatelessWidget {
  final double value;
  final String unit;
  final int decimals;

  const AnimatedCounter({
    super.key,
    required this.value,
    required this.unit,
    this.decimals = 1,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: value),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeOutCubic,
      builder: (context, animatedValue, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              animatedValue.toStringAsFixed(decimals),
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: AppConstants.tealColor,
              ),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                unit,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode
                      ? AppConstants.tealColor.withOpacity(0.8)
                      : AppConstants.tealColor.withOpacity(0.8),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
