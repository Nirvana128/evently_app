import 'package:evently/core/extensions/responsive_size_extension.dart';
import 'package:evently/models/event_type.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/main_layout/tabs/home/widgets/appbar_title.dart';
import 'package:evently/ui/main_layout/tabs/home/widgets/custom_tab_bar.dart';
import 'package:evently/ui/main_layout/tabs/home/widgets/event_list_view.dart';
import 'package:evently/ui/main_layout/tabs/home/widgets/mode_changer.dart';
import 'package:evently/ui/main_layout/tabs/home/widgets/language_changer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late final EventsProvider readEventsProvider;

  @override
  void initState() {
    super.initState();
    readEventsProvider = context.read<EventsProvider>();
    readEventsProvider.selectedEventTypeIndex = 0;
    getEvents();
  }

  void getEvents() async {
    await readEventsProvider.getAllEvents(
      context.read<UserProvider>().currentUser?.uid ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    final eventTab = EventType.getEventTypes(context);
    final eventsProvider = context.watch<EventsProvider>();

    return DefaultTabController(
      length: eventTab.length,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: AppbarTitle(),
          actions: [ModeChanger(), LanguageChanger()],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60.height),
            child: CustomTabBar(
              eventTab: eventTab,
              selectedIndex: eventsProvider.selectedEventTypeIndex,
              context: context,
              onTap: (index) {
                context.read<EventsProvider>().changeSelectedEventTypeIndex(
                  index,
                );
                if (index == 0) {
                  context.read<EventsProvider>().getAllEvents(
                    context.read<UserProvider>().currentUser?.uid ?? '',
                  );
                  print('index: $index');
                } else {
                  context.read<EventsProvider>().getFilteredEventsByEventType(
                    context.read<UserProvider>().currentUser?.uid ?? '',
                    eventTab[index].etId,
                    // Issue: Filtering by localized names failed when the language changed to Arabic.
                    // Solution: Used a static unique ID for database queries instead of the translated display name.
                  );
                  print('index: $index');
                }
              },
            ),
          ),
        ),
        body: EventListView(
          events: eventsProvider.selectedEventTypeIndex == 0
              ? eventsProvider.events
              : eventsProvider.filteredEvents,
        ),
      ),
    );
  }
}
