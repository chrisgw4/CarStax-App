import 'package:flutter/material.dart';

class ValueTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const ValueTextField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.inverseSurface,
          fontSize: 16
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
