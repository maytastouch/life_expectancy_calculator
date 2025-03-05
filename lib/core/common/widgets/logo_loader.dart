import 'package:flutter/material.dart';

class LogoLoader extends StatelessWidget {
  const LogoLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            const CircularProgressIndicator(
              strokeWidth: 2,
            ),
            Image.asset(
              'assets/images/Screenshot_2023-03-16_at_2.20.53_PM-removebg-preview.png',
              width: 30,
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
