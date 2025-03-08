import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart'; // Import AppConstants

class CountryDropdown extends StatelessWidget {
  final List<String> countries;
  final String? selectedCountry;
  final Function(String?) onCountryChanged;

  const CountryDropdown({
    super.key,
    required this.countries,
    required this.selectedCountry,
    required this.onCountryChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Country',
        labelStyle: const TextStyle(
            color: AppConstants.tealColor), // Use teal color directly
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
              color: AppConstants.tealColor), // Use teal color directly
        ),
        filled: true,
        fillColor: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade50,
      ),
      style: TextStyle(
        color: isDarkMode ? Colors.white : Colors.black87,
      ),
      dropdownColor: isDarkMode ? Colors.grey.shade800 : Colors.white,
      value: selectedCountry,
      items: countries.map((country) {
        return DropdownMenuItem<String>(
          value: country,
          child: Text(country),
        );
      }).toList(),
      onChanged: onCountryChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a country';
        }
        return null;
      },
    );
  }
}
