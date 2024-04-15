import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      // Trigger the Google Authentication flow.
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        // Obtain the auth details from the request.
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Create a new credential.
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase with the Google [UserCredential].
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          // Update user data in Firestore
          updateUserFirestore(user, googleUser);
        }
        return user;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    return null;
  }

  Future<void> updateUserFirestore(
      User user, GoogleSignInAccount googleUser) async {
    DocumentReference userRef = _db.collection('users').doc(user.uid);

    return userRef.set(
        {
          'firstName': googleUser.displayName
              ?.split(' ')
              ?.first, // Assuming displayName is 'First Last'
          'lastName': googleUser.displayName?.split(' ')?.last,
          'email': googleUser.email,
          'profileImageUrl': googleUser.photoUrl ?? 'default_image_url',
        },
        SetOptions(
            merge: true)); // Use merge option to update user data if it exists
  }
}
