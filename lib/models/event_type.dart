import 'package:evently/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:evently/l10n/app_localizations.dart';

class EventType {
  final String etId;
  final IconData icon;
  final String name;
  final String imagePath;

  EventType({required this.etId, required this.icon, required this.name, required this.imagePath});
  
  static List<EventType> getEventTypes(BuildContext context) => [
    EventType(
      etId: 'All',
      icon: Icons.widgets,
      name: AppLocalizations.of(context)!.all,
      imagePath: '',
    ),
    EventType(
      etId: 'Sports',
      icon: Icons.directions_bike,
      name: AppLocalizations.of(context)!.sport,
      imagePath: Assets.imagesSportLight
    ),
    EventType(
      etId: 'Birthday',
      icon: Icons.cake,
      name: AppLocalizations.of(context)!.birthday,
      imagePath: Assets.imagesBirthdayLight,
    ),
    EventType(
      etId: 'Book club',
      icon: Icons.menu_book,
      name: AppLocalizations.of(context)!.bookClub,
      imagePath: Assets.imagesBookClubLight,
    ),
    EventType(
      etId: 'Exhibition',
      icon: Icons.art_track,
      name: AppLocalizations.of(context)!.exhibition,
      imagePath: Assets.imagesExhibitionLight,
    ),
    EventType(
      etId: 'Meetings',
      icon: Icons.view_carousel,
      name: AppLocalizations.of(context)!.meetings,
      imagePath: Assets.imagesMeetingLight,
    ),
  ];
}