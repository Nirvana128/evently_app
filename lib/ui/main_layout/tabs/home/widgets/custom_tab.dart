import 'package:evently/core/extensions/responsive_padding_extension.dart';
import 'package:evently/core/extensions/responsive_sized_box_extension.dart';
import 'package:evently/models/event_type.dart';
import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  final EventType e;
  final bool isSelected;
  const CustomTab({super.key, required this.e, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: 5.horizontalPadding,
        child: Row(
          children: [
            Icon(e.icon, size: 22),
            8.horizontalSizedBox,
            Text(
              e.name,
              style: isSelected
                  ? Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: Colors.white)
                  : Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
