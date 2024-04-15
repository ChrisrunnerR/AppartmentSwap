import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreService {
  // get collectino of notes
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  //create   -- add in later //  String profileImageUrl
  Future<void> createUserProfile(User user, String firstName, String lastName,
      [String? profileImageUrl]) async {
    await users.doc(user.uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'profileImageUrl': profileImageUrl ??
          'default_image_url', // Use a default or handle null appropriately
    });
  }
  // Firestore DB

  //read
  Stream<QuerySnapshot> getUserStream() {
    final usersStream = users.orderBy('fname', descending: true).snapshots();
    return usersStream;
  }

// get current userID
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return snapshot.data() as Map<String, dynamic>?;
  }

  //update

  //delete
}
