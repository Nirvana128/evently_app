import 'package:cloud_firestore/cloud_firestore.dart';
class Event {
  static const String collectionName = 'events';

  String id;
  String eventType;
  DateTime dateTime;
  String title;
  String description;
  String imagePath;
  bool isFavorite;

  Event({
    required this.eventType,
    required this.dateTime,
    required this.title,
    required this.imagePath,
    required this.description,
    this.isFavorite = false,
    this.id = '',
  });

  Event.fromJson(Map<String, dynamic> json)
    : this(
        id: json['id'] as String,
        eventType: json['eventType'] as String,
        dateTime: (json['dateTime'] as Timestamp).toDate(),
        title: json['title'] as String,
        description: json['description'] as String,
        imagePath: json['imagePath'] as String,
        isFavorite: json['isFavorite'] as bool,
      );

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'eventType': eventType,
      'dateTime': dateTime,
      'title': title,
      'description': description,
      'imagePath': imagePath,
      'isFavorite': isFavorite,
    };
  }

  // static List<Event> getEvents() {
  //   return [
  //     Event(
  //       id: '1',
  //       description:
  //           'Join us for an unforgettable night of music and fun at our live concert featuring The Rockers! Get ready to rock out to their greatest hits and enjoy an electrifying atmosphere. Don\'t miss this chance to experience the energy and excitement of a live performance by one of the hottest bands in town. Grab your tickets now and let\'s make memories together!',
  //       eventType: 'Sport',
  //       dateTime: DateTime.now().add(Duration(days: 1, hours: 18)),
  //       title: 'Live Concert by The Rockers',
  //       imagePath: Assets.imagesSportLight,
  //       isFavorite: false,
  //     ),
  //     Event(
  //       id: '2',
  //       description:
  //           'Experience the beauty of modern art in our latest exhibition. Featuring works from emerging artists and established masters, this showcase explores themes of identity, culture, and innovation. Don\'t miss this opportunity to immerse yourself in a world of creativity and artistic expression.',
  //       eventType: 'Birthday',
  //       dateTime: DateTime.now().add(Duration(days: 3, hours: 15)),
  //       title: 'Modern Art Exhibition',
  //       imagePath: Assets.imagesBirthdayLight,
  //       isFavorite: false,
  //     ),
  //     Event(
  //       id: '3',
  //       description:
  //           'Join us for an engaging conference on the latest trends in technology and innovation. Learn from industry experts and network with fellow professionals in a dynamic environment.',
  //       eventType: 'Book Club',
  //       dateTime: DateTime.now().add(Duration(days: 5, hours: 10)),
  //       title: 'Tech Innovations Conference',
  //       imagePath: Assets.imagesBookClubLight,
  //       isFavorite: true,
  //     ),
  //   ];
  // }
}
