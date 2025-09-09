import 'package:flutter/material.dart';

class ApiToggle extends StatelessWidget {
  final bool isApi1;
  final Function(bool) onToggle;

  const ApiToggle({
    super.key,
    required this.isApi1,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('API 1'),
        Switch(
          value: isApi1,
          onChanged: onToggle,
        ),
        const Text('API 2'),
      ],
    );
  }
}