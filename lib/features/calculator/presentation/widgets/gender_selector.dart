import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';

class GenderSelector extends StatelessWidget {
  final String selectedGender;
  final Function(String) onGenderChanged;

  const GenderSelector({
    super.key,
    required this.selectedGender,
    required this.onGenderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gender',
          style: TextStyle(color: AppConstants.tealColor, fontSize: 14),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _GenderOption(
                value: 'female',
                label: 'Female',
                icon: Icons.female,
                isSelected: selectedGender == 'female',
                onSelected: onGenderChanged,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _GenderOption(
                value: 'male',
                label: 'Male',
                icon: Icons.male,
                isSelected: selectedGender == 'male',
                onSelected: onGenderChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _GenderOption extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final bool isSelected;
  final Function(String) onSelected;

  const _GenderOption({
    required this.value,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final selectedColor = isDarkMode
        ? AppConstants.tealColor.withOpacity(0.3)
        : AppConstants.tealColor.withOpacity(0.1);
    final unselectedColor =
        isDarkMode ? Colors.grey.shade800 : Colors.grey.shade50;

    const borderSelectedColor = AppConstants.tealColor;
    final borderUnselectedColor =
        isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300;

    const iconSelectedColor = AppConstants.tealColor;
    final iconUnselectedColor =
        isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600;

    const textSelectedColor = AppConstants.tealColor;
    final textUnselectedColor =
        isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700;

    return GestureDetector(
      onTap: () => onSelected(value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? selectedColor : unselectedColor,
          border: Border.all(
            color: isSelected ? borderSelectedColor : borderUnselectedColor,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? iconSelectedColor : iconUnselectedColor,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? textSelectedColor : textUnselectedColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
