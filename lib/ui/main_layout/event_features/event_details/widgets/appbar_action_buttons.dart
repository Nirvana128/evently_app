import 'package:evently/core/extensions/responsive_size_extension.dart';
import 'package:flutter/material.dart';

class AppbarActionButtons extends StatelessWidget {
  final VoidCallback onTap;
  final Icon icon;

  const AppbarActionButtons({super.key, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.square,
      width: 32.square,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(onTap: onTap, child: icon),
    );
  }
}
