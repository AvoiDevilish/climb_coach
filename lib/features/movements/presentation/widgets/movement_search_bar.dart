import 'package:flutter/material.dart';

class MovementSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const MovementSearchBar({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: 'جستجوی حرکت...',
        border: OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}