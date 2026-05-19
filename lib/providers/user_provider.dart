import 'package:evently/models/user.dart';
import 'package:evently/services/firebase_service.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserModel? currentUser;

  // Fetch events filtered by event type
  Future<void> getUserData(
    String userId,
  ) async {
    currentUser = await FirebaseService.getUserFromFirestore(
      userId,
    );
    notifyListeners();
  }

  void updateUserData(UserModel updatedUser) {
    currentUser = updatedUser;
    notifyListeners();
  }
}