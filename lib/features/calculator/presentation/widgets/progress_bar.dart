import 'package:flutter/material.dart';

class AnimatedProgressBar extends StatelessWidget {
  final DateTime birthDate;
  final double lifeExpectancy;

  const AnimatedProgressBar({
    super.key,
    required this.birthDate,
    required this.lifeExpectancy,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate progress based on actual days lived
    final today = DateTime.now();
    final daysLived = today.difference(birthDate).inDays;
    final totalDays = (lifeExpectancy * 365.25).round();
    final progress = daysLived / totalDays;

    // Clamp progress between 0 and 1
    final clampedProgress = progress.clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Life Progress: ${(clampedProgress * 100).toStringAsFixed(1)}%',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.teal,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${daysLived.toStringAsFixed(0)} / ${totalDays.toStringAsFixed(0)} days',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: clampedProgress),
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeOutQuad,
          builder: (context, animatedValue, child) {
            return LinearProgressIndicator(
              value: animatedValue,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.teal),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            );
          },
        ),
      ],
    );
  }
}
