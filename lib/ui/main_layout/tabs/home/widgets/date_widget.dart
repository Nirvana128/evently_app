import 'package:evently/core/extensions/responsive_padding_extension.dart';
import 'package:evently/core/extensions/responsive_sized_box_extension.dart';
import 'package:evently/models/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatelessWidget {
  final Event event;
  const DateWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 5.allPadding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisSize: .min,
        children: [
          Text(
            event.dateTime.day.toString(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          2.horizontalSizedBox,
          Text(
            DateFormat(
              'MMM',
              Localizations.localeOf(context).languageCode,
            ).format(event.dateTime),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
