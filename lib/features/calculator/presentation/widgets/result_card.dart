import 'package:flutter/material.dart';
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
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  const Text(
                    'YOUR REMAINING TIME',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.teal,
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
                      style: const TextStyle(
                        color: Colors.black54,
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
