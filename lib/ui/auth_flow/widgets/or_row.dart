import 'package:evently/core/extensions/responsive_sized_box_extension.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class OrRow extends StatelessWidget {
  const OrRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Theme.of(context).colorScheme.onSurface,
            thickness: 2,
          ),
        ),
        10.horizontalSizedBox,
        Text(
          AppLocalizations.of(context)!.or,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        10.horizontalSizedBox,
        Expanded(
          child: Divider(
            color: Theme.of(context).colorScheme.onSurface,
            thickness: 2,
          ),
        ),
      ],
    );
  }
}
