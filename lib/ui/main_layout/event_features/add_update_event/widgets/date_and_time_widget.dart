import 'package:evently/core/extensions/responsive_sized_box_extension.dart';
import 'package:flutter/material.dart';

class DateAndTimeWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String buttonText;
  final VoidCallback? onTap;
  const DateAndTimeWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.buttonText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 25, color: Theme.of(context).colorScheme.primary),
        8.horizontalSizedBox,
        Text(label, style: Theme.of(context).textTheme.titleMedium),
        Spacer(),
        TextButton(
          onPressed: onTap,
          child: Text(
            buttonText,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              decoration: TextDecoration.underline,
              decorationColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}