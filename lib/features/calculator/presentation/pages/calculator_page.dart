import 'package:flutter/material.dart';

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
        final age =
            today.year -
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        title: const Text(
          'LIFE CALCULATOR',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Find out how much time you have left based on life expectancy data.',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 40),
                _buildForm(),
                const SizedBox(height: 40),
                if (_showResult) _buildResultCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildCountryDropdown(),
          const SizedBox(height: 24),
          _buildBirthDatePicker(),
          const SizedBox(height: 24),
          _buildGenderSelector(),
          const SizedBox(height: 36),
          _buildCalculateButton(),
        ],
      ),
    );
  }

  Widget _buildCountryDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Country',
        labelStyle: const TextStyle(color: Colors.teal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.teal),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
      style: const TextStyle(color: Colors.black87),
      value: _selectedCountry,
      items:
          _countries.map((country) {
            return DropdownMenuItem<String>(
              value: country,
              child: Text(country),
            );
          }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedCountry = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a country';
        }
        return null;
      },
    );
  }

  Widget _buildBirthDatePicker() {
    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: _birthDate ?? DateTime(2000),
          firstDate: DateTime(1920),
          lastDate: DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: Colors.teal,
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: Colors.black87,
                ),
              ),
              child: child!,
            );
          },
        );
        if (date != null) {
          setState(() {
            _birthDate = date;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.grey.shade50,
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, color: Colors.teal, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _birthDate == null
                    ? 'Select birth date'
                    : '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}',
                style: TextStyle(
                  color:
                      _birthDate == null
                          ? Colors.grey.shade600
                          : Colors.black87,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gender',
          style: TextStyle(color: Colors.teal, fontSize: 14),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildGenderOption('female', 'Female', Icons.female),
            ),
            const SizedBox(width: 16),
            Expanded(child: _buildGenderOption('male', 'Male', Icons.male)),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderOption(String value, String label, IconData icon) {
    final isSelected = _selectedGender == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? Colors.teal.shade50 : Colors.grey.shade50,
          border: Border.all(
            color: isSelected ? Colors.teal : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.teal : Colors.grey.shade600,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.teal : Colors.grey.shade700,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalculateButton() {
    return ElevatedButton(
      onPressed: _calculateLifeExpectancy,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
      child: const Text(
        'CALCULATE',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeInAnimation.value,
          child: Transform.translate(
            offset: Offset(0, _slideAnimation.value),
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
                  _buildCounterAnimation(_yearsLeft, 'YEARS'),
                  const SizedBox(height: 16),
                  _buildCounterAnimation(_daysLeft, 'DAYS', decimals: 0),
                  const SizedBox(height: 24),
                  _buildProgressIndicator(),
                  const SizedBox(height: 24),
                  if (_expectedEndDate != null)
                    Text(
                      'Expected end date: ${_expectedEndDate!.day}/${_expectedEndDate!.month}/${_expectedEndDate!.year}',
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

  Widget _buildCounterAnimation(double value, String unit, {int decimals = 1}) {
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
                color: Colors.teal,
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
                  color: Colors.teal.shade700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProgressIndicator() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeOutQuad,
      builder: (context, animatedValue, child) {
        return LinearProgressIndicator(
          value: animatedValue,
          backgroundColor: Colors.grey.shade200,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        );
      },
    );
  }
}
