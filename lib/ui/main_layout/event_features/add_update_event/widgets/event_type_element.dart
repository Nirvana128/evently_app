import 'package:evently/core/extensions/responsive_padding_extension.dart';
import 'package:evently/core/extensions/responsive_sized_box_extension.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/models/event_type.dart';
import 'package:flutter/material.dart';

class EventTypeElement extends StatelessWidget {
  final EventType eventTab;
  final VoidCallback onTap;
  final bool isSelected;

  const EventTypeElement({
    super.key,
    required this.eventTab,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: 10.horizontalPadding,
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface,
          ),
        ),
        child: Row(
          children: [
            Icon(
              eventTab.icon,
              size: 22,
              color: isSelected ? AppColors.white : theme.colorScheme.primary,
            ),
            8.horizontalSizedBox,
            Text(
              eventTab.name,
              style: isSelected
                  ? theme.textTheme.titleMedium!.copyWith(
                      color: AppColors.white,
                    )
                  : theme.textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}