import 'package:evently/core/extensions/responsive_padding_extension.dart';
import 'package:evently/core/extensions/responsive_sized_box_extension.dart';
import 'package:evently/models/event.dart';
import 'package:evently/ui/main_layout/tabs/home/widgets/event_item.dart';
import 'package:flutter/material.dart';

class FavoriteEventListView extends StatelessWidget {
  final List<Event> events;
  const FavoriteEventListView({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: 16.verticalPadding,
      separatorBuilder: (context, index) => 16.verticalSizedBox,
      itemCount: events.length,
      itemBuilder: (context, index) {
        return EventItem(event: events[index]);
      },
    );
  }
}
