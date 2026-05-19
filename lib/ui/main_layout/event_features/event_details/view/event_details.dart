import 'package:evently/core/constants/app_padding.dart';
import 'package:evently/core/extensions/responsive_sized_box_extension.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/event.dart';
import 'package:evently/ui/main_layout/event_features/add_update_event/widgets/event_image.dart';
import 'package:evently/ui/main_layout/event_features/event_details/widgets/edit_app_bar.dart';
import 'package:evently/ui/main_layout/event_features/event_details/widgets/event_info_container.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EventDetails extends StatefulWidget {
  const EventDetails({super.key,});
  
  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  Event? editedEventModel;

  @override
  Widget build(BuildContext context) {
    final event = editedEventModel ?? ModalRoute.of(context)!.settings.arguments as Event;

    return Scaffold(
      appBar: EditAppBar(
        onEventUpdated: (newEvent) {
          setState(() {
            editedEventModel = newEvent;
          });
        },
      ),
      body: Padding(
        padding: AppPadding.view,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Event image
                EventImage(imagePath: event.imagePath),

                // Event title
                16.verticalSizedBox,
                Text(
                  event.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                8.verticalSizedBox,
                EventInfoContainer(dateTime: event.dateTime),

                // Event description
                16.verticalSizedBox,
                Text(
                  AppLocalizations.of(context)!.description,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                8.verticalSizedBox,
                EventInfoContainer(text: event.description),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
