import 'package:evently/models/event_type.dart';
import 'package:evently/ui/main_layout/tabs/home/widgets/custom_tab.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.eventTab,
    required this.context,
    required this.onTap,
    required this.selectedIndex,
  });

  final List<EventType> eventTab;
  final BuildContext context;
  final int selectedIndex;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabAlignment: TabAlignment.start,
      isScrollable: true,
      labelColor: Colors.white,
      dividerHeight: 0,
      labelPadding: EdgeInsets.zero,
      onTap: (index) => onTap(index),
      tabs: eventTab.map((e) => CustomTab(e: e, isSelected: eventTab.indexOf(e) == selectedIndex)).toList(),
    );
  }
}
