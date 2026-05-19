import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event.dart';
import 'package:evently/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignIn signIn = GoogleSignIn.instance;

    signIn.initialize(
      serverClientId:
          '643907720058-arb2qf3qcvnvccsn0n6tdbc77eokncap.apps.googleusercontent.com',
    );

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn.instance
        .authenticate();

    if (googleUser == null) return null;

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Get user collection reference
  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toFirestore(),
        );
  }

  // Add user to Firestore
  static Future<void> addUserToFirestore(UserModel user) async {
    await getUserCollection().doc(user.uid).set(user);
  }

  // Get user from Firestore
  static Future<UserModel?> getUserFromFirestore(String uid) async {
    final docSnapShot = await getUserCollection().doc(uid).get();
    return docSnapShot.data();
  }

  // Get events collection reference for a specific user
  static CollectionReference<Event> getEventsCollection(String userId) {
    return getUserCollection()
        .doc(userId)
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, _) => Event.fromJson(snapshot.data()!),
          toFirestore: (event, _) => event.toFirestore(),
        );
  }

  // Add event to Firestore for a specific user
  static Future<void> addEventToFirestore(Event event, String userId) async {
    DocumentReference<Event> docRef = getEventsCollection(
      userId,
    ).doc(); // Auto-generate ID
    event.id = docRef.id; // Set the generated ID to the event
    await docRef.set(event);
  }

  // Get events from Firestore for a specific user
  static Future<List<Event>> getEventsFromFirestore(String userId) async {
    final querySnapshot = await getEventsCollection(
      userId,
    ).orderBy('dateTime').get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  // Get favorite events from Firestore for a specific user
  static Future<List<Event>> getFavoriteEventsFromFirestore(
    String userId,
  ) async {
    final querySnapshot = await getEventsCollection(
      userId,
    ).where('isFavorite', isEqualTo: true).orderBy('dateTime').get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  // Update an event in Firestore for a specific user
  static Future<void> updateEventInFirestore(Event event, String userId) async {
    await getEventsCollection(userId).doc(event.id).update(event.toFirestore());
  }

  // Update favorite status of an event in Firestore for a specific user
  static Future<void> updateFavoriteEventsInFirestore(
    String userId,
    String eventId,
    bool isFavorite,
  ) async {
    await getEventsCollection(
      userId,
    ).doc(eventId).update({'isFavorite': isFavorite});
  }

  // Get filtered events by event type from Firestore for a specific user
  static Future<List<Event>> getFilteredEventsFromFirestore(
    String userId,
    String eventType,
  ) async {
    final querySnapshot = await getEventsCollection(
      userId,
    ).where('eventType', isEqualTo: eventType).orderBy('dateTime').get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  // Get filtered favorite events by event type from Firestore for a specific user
  static Future<List<Event>> getFilteredFavoriteEventsFromFirestore(
    String userId,
    String eventType,
  ) async {
    final querySnapshot = await getEventsCollection(userId)
        .where('eventType', isEqualTo: eventType)
        .where('isFavorite', isEqualTo: true)
        .orderBy('dateTime')
        .get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  
}