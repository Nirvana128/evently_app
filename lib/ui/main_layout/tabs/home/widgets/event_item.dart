import 'package:evently/core/constants/app_routes.dart';
import 'package:evently/core/extensions/image_changer_theme_extension.dart';
import 'package:evently/core/extensions/responsive_padding_extension.dart';
import 'package:evently/core/extensions/responsive_size_extension.dart';
import 'package:evently/models/event.dart';
import 'package:evently/ui/main_layout/tabs/home/widgets/date_widget.dart';
import 'package:evently/ui/main_layout/tabs/home/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  final Event event;
  const EventItem({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    String imgPath = event.imagePath.changeImageTheme(context);
    return InkWell(
      onTap: () {
        // Navigate to event details view
        Navigator.pushNamed(context, AppRoutes.eventDetailsView, arguments: event);
      },
      child: Container(
        height: 210.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(imgPath),
            fit: BoxFit.fill,
          ),
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface,
            width: 2,
          ),
        ),
        child: Padding(
          padding: 10.allPadding,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              DateWidget(event: event),
              Spacer(),
              TitleWidget(event: event ),
            ]),
        ),
      ),
    );
  }
}