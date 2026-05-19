import 'package:evently/core/extensions/responsive_padding_extension.dart';
import 'package:evently/models/event.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TitleWidget extends StatefulWidget {
  final Event event;
  const TitleWidget({super.key, required this.event});

  @override
  State<TitleWidget> createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 5.horizontalPadding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Text(
            widget.event.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              setState(() {
                widget.event.isFavorite = !widget.event.isFavorite;
                context.read<EventsProvider>().updateFavoriteEvents(
                  context.read<UserProvider>().currentUser?.uid ?? '',
                  widget.event.id,
                  widget.event.isFavorite,
                );
              });
            },
            icon: widget.event.isFavorite
                ? Icon(
                    Icons.favorite,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : Icon(
                    Icons.favorite_border,
                    color: Theme.of(context).colorScheme.primary,
                  ),
          ),
        ],
      ),
    );
  }
}
