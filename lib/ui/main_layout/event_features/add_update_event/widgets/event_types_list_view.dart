import 'package:evently/core/extensions/responsive_size_extension.dart';
import 'package:evently/core/extensions/responsive_sized_box_extension.dart';
import 'package:evently/models/event_type.dart';
import 'package:evently/ui/main_layout/event_features/add_update_event/widgets/event_type_element.dart';
import 'package:flutter/material.dart';

class EventTypesListView extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  const EventTypesListView({super.key, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final eventTab = EventType.getEventTypes(context).sublist(1);

    return SizedBox(
      height: 40.height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: eventTab.length,
        separatorBuilder: (context, index) => 16.horizontalSizedBox,
        itemBuilder: (context, index) {
          return EventTypeElement(
            eventTab: eventTab[index],
            onTap: () => onTap(index),
            isSelected: selectedIndex == index,
          );
        },
      ),
    );
  }
}
