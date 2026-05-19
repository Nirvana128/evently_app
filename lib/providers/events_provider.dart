import 'package:evently/models/event.dart';
import 'package:evently/services/firebase_service.dart';
import 'package:flutter/material.dart';

class EventsProvider extends ChangeNotifier {
  int selectedEventTypeIndex = 0;
  List<Event> events = [];
  List<Event> filteredEvents = [];
  List<Event> favoriteEvents = [];
  List<Event> filteredFavoriteEvents = [];

  // Change the selected event type index and notify listeners
  void changeSelectedEventTypeIndex(int index) {
    selectedEventTypeIndex = index;
    notifyListeners();
  }

  // Fetch all events for the current user
  Future<void> getAllEvents(String userId) async {
    events = await FirebaseService.getEventsFromFirestore(userId);
    notifyListeners();
  }

  // Fetch events filtered by event type
  Future<void> getFilteredEventsByEventType(
    String userId,
    String eventType,
  ) async {
    filteredEvents = await FirebaseService.getFilteredEventsFromFirestore(
      userId,
      eventType,
    );
    notifyListeners();
  }

  // Fetch filtered favorite events by event type
  Future<void> updateFavoriteEvents(
    String userId,
    String eventId,
    bool isFavorite,
  ) async {
    await FirebaseService.updateFavoriteEventsInFirestore(
      userId,
      eventId,
      isFavorite,
    );
    notifyListeners();
  }

  // Fetch favorite events for the current user
  Future<void> getFavoriteEvents(String userId) async {
    favoriteEvents = await FirebaseService.getFavoriteEventsFromFirestore(
      userId,
    );

    filteredFavoriteEvents = favoriteEvents;
    notifyListeners();
  }

  void deleteEvent(String userId, String eventId) async {
    await FirebaseService.getEventsCollection(userId).doc(eventId).delete();
    events.removeWhere((event) => event.id == eventId);
    filteredEvents.removeWhere((event) => event.id == eventId);
    notifyListeners();
  }

  void updateEvent(Event event, String userId) async {
    await FirebaseService.getEventsCollection(
      userId,
    ).doc(event.id).update(event.toFirestore());
    notifyListeners();
  }

  void searchInFavoriteEvents(String query) {
    if (query.isEmpty) {
      filteredFavoriteEvents = favoriteEvents;
    } else {
      filteredFavoriteEvents = favoriteEvents.where((event) {
        final title = event.title.toLowerCase();
        final search = query.toLowerCase();
        return title.contains(search);
      }).toList();
    }
    notifyListeners();
  }
}
