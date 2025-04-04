import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
          height: 10,
          width: 10,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          )),
    );
  }
}
