import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';
import 'animated_counter.dart';
import 'progress_bar.dart';

class ResultCard extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Animation<double> slideAnimation;
  final double yearsLeft;
  final double daysLeft;
  final DateTime? expectedEndDate;
  final DateTime birthDate;
  final double lifeExpectancy;

  const ResultCard({
    super.key,
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.yearsLeft,
    required this.daysLeft,
    required this.expectedEndDate,
    required this.birthDate,
    required this.lifeExpectancy,
  });

  @override
  Widget build(BuildContext context) {
    // Instead of using Theme.of(context).brightness, get it directly from BlocBuilder
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: fadeAnimation.value,
          child: Transform.translate(
            offset: Offset(0, slideAnimation.value),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.black12 : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color:
                      isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'YOUR REMAINING TIME',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppConstants.tealColor,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 24),
                  AnimatedCounter(value: yearsLeft, unit: 'YEARS'),
                  const SizedBox(height: 16),
                  AnimatedCounter(value: daysLeft, unit: 'DAYS', decimals: 0),
                  const SizedBox(height: 24),
                  AnimatedProgressBar(
                    birthDate: birthDate,
                    lifeExpectancy: lifeExpectancy,
                  ),
                  const SizedBox(height: 24),
                  if (expectedEndDate != null)
                    Text(
                      'Expected end date: ${expectedEndDate!.day}/${expectedEndDate!.month}/${expectedEndDate!.year}',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
