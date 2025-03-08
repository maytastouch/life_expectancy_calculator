import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';

class BirthDatePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const BirthDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime(2000),
          firstDate: DateTime(1920),
          lastDate: DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppConstants.tealColor,
                  onPrimary: Colors.white,
                  surface: isDarkMode ? Colors.grey.shade800 : Colors.white,
                  onSurface: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
              child: child!,
            );
          },
        );
        if (date != null) {
          onDateSelected(date);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
          ),
          color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade50,
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today,
                color: AppConstants.tealColor, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                selectedDate == null
                    ? 'Select birth date'
                    : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                style: TextStyle(
                  color: selectedDate == null
                      ? (isDarkMode
                          ? Colors.grey.shade400
                          : Colors.grey.shade600)
                      : (isDarkMode ? Colors.white : Colors.black87),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
