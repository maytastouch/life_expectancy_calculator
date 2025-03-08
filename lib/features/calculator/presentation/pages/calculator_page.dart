import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/bloc/theme_bloc.dart';
import '../../../../core/theme/bloc/theme_state.dart';
import '../../../../core/constants/constants.dart'; // Import AppConstants
import '../widgets/country_dropdown.dart';
import '../widgets/birth_date_picker.dart';
import '../widgets/gender_selector.dart';
import '../widgets/result_card.dart';
import '../widgets/calculate_button.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _slideAnimation;

  DateTime? _birthDate;
  String _selectedGender = 'female';
  String? _selectedCountry;
  bool _showResult = false;

  // Static data for demonstration
  final List<String> _countries = [
    'United States',
    'United Kingdom',
    'Japan',
    'Australia',
    'Canada',
    'Germany',
    'France',
    'Spain',
    'Italy',
    'Brazil',
    'Mexico',
    'India',
    'China',
    'South Korea',
    'Russia',
  ];

  // Static calculation results
  final Map<String, Map<String, double>> _lifeExpectancy = {
    'United States': {'male': 76.1, 'female': 81.1},
    'United Kingdom': {'male': 79.0, 'female': 82.9},
    'Japan': {'male': 81.1, 'female': 87.1},
    'Australia': {'male': 80.9, 'female': 85.0},
    'Canada': {'male': 80.2, 'female': 84.1},
    'Germany': {'male': 78.6, 'female': 83.4},
    'France': {'male': 79.2, 'female': 85.3},
    'Spain': {'male': 80.7, 'female': 86.2},
    'Italy': {'male': 80.5, 'female': 84.9},
    'Brazil': {'male': 71.9, 'female': 79.3},
    'Mexico': {'male': 72.1, 'female': 77.8},
    'India': {'male': 68.2, 'female': 70.7},
    'China': {'male': 74.5, 'female': 77.9},
    'South Korea': {'male': 79.8, 'female': 85.8},
    'Russia': {'male': 66.4, 'female': 76.8},
  };

  double _yearsLeft = 0;
  double _daysLeft = 0;
  DateTime? _expectedEndDate;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeInAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _slideAnimation = Tween<double>(begin: 50, end: 0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutQuad),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _calculateLifeExpectancy() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_birthDate != null && _selectedCountry != null) {
        // Calculate age
        final today = DateTime.now();
        final age = today.year -
            _birthDate!.year -
            (today.month < _birthDate!.month ||
                    (today.month == _birthDate!.month &&
                        today.day < _birthDate!.day)
                ? 1
                : 0);

        // Get life expectancy from static data
        final countryData = _lifeExpectancy[_selectedCountry!];
        final lifeExpectancy = countryData?[_selectedGender] ?? 80.0;

        setState(() {
          _yearsLeft = lifeExpectancy - age;
          _daysLeft = _yearsLeft * 365.25;

          // Calculate expected end date
          int totalDaysToLive = (lifeExpectancy * 365.25).round();
          _expectedEndDate = DateTime(
            _birthDate!.year,
            _birthDate!.month,
            _birthDate!.day,
          ).add(Duration(days: totalDaysToLive));

          _showResult = true;
        });

        _animationController.reset();
        _animationController.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    final screenWidth = MediaQuery.of(context).size.width;
    // Calculate content width (use 90% on small screens, fixed width on larger screens)
    final contentWidth = screenWidth < 600 ? screenWidth * 0.9 : 500.0;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        // Instead of comparing object reference, check the brightness directly
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: AppConstants.tealColor, // Use teal color directly
            elevation: 0,
            title: const Text(
              'LIFE CALCULATOR',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
                color: Colors.white,
              ),
            ),
            actions: [
              BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) {
                  // Use the isDarkMode property directly
                  final isDarkMode = state.isDarkMode;
                  return IconButton(
                    icon: Icon(
                      isDarkMode ? Icons.light_mode : Icons.dark_mode,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      print(
                          'Toggle button pressed: current mode is ${isDarkMode ? "dark" : "light"}');
                      if (isDarkMode) {
                        context.read<ThemeBloc>().add(ThemeEvent.toggleLight);
                      } else {
                        context.read<ThemeBloc>().add(ThemeEvent.toggleDark);
                      }
                    },
                    tooltip: isDarkMode
                        ? 'Switch to Light Mode'
                        : 'Switch to Dark Mode',
                  );
                },
              ),
            ],
          ),
          body: SafeArea(
            child: Center(
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: contentWidth),
                    padding: const EdgeInsets.symmetric(
                        vertical: 24.0, horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          'Find out how much time you have left based on life expectancy data.',
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white70
                                    : Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 40),
                        _buildForm(),
                        const SizedBox(height: 40),
                        if (_showResult)
                          ResultCard(
                            fadeAnimation: _fadeInAnimation,
                            slideAnimation: _slideAnimation,
                            yearsLeft: _yearsLeft,
                            daysLeft: _daysLeft,
                            expectedEndDate: _expectedEndDate,
                            birthDate: _birthDate!,
                            lifeExpectancy: _yearsLeft + _calculateCurrentAge(),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CountryDropdown(
            countries: _countries,
            selectedCountry: _selectedCountry,
            onCountryChanged: (value) {
              setState(() {
                _selectedCountry = value;
              });
            },
          ),
          const SizedBox(height: 24),
          BirthDatePicker(
            selectedDate: _birthDate,
            onDateSelected: (date) {
              setState(() {
                _birthDate = date;
              });
            },
          ),
          const SizedBox(height: 24),
          GenderSelector(
            selectedGender: _selectedGender,
            onGenderChanged: (value) {
              setState(() {
                _selectedGender = value;
              });
            },
          ),
          const SizedBox(height: 36),
          CalculateButton(onPressed: _calculateLifeExpectancy),
        ],
      ),
    );
  }

  // Helper method to calculate current age
  double _calculateCurrentAge() {
    if (_birthDate == null) return 0;

    final today = DateTime.now();
    final age = today.year -
        _birthDate!.year -
        (today.month < _birthDate!.month ||
                (today.month == _birthDate!.month &&
                    today.day < _birthDate!.day)
            ? 1
            : 0);

    // Add fractional part of the year
    final birthDayThisYear = DateTime(
      today.year,
      _birthDate!.month,
      _birthDate!.day,
    );
    final daysInYear = DateTime(today.year + 1, 1, 1)
        .difference(DateTime(today.year, 1, 1))
        .inDays;

    double fractionalAge = age.toDouble();
    if (birthDayThisYear.isBefore(today)) {
      // Birthday already passed this year
      final daysSinceBirthday = today.difference(birthDayThisYear).inDays;
      fractionalAge += daysSinceBirthday / daysInYear;
    } else {
      // Birthday hasn't passed yet
      final daysUntilBirthday = birthDayThisYear.difference(today).inDays;
      fractionalAge += (daysInYear - daysUntilBirthday) / daysInYear;
    }

    return fractionalAge;
  }
}
