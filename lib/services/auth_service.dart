import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  signInWithGoogle() async {
    // bring up interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // Check if the user cancelled the sign-in process
    if (gUser == null) {
      // User cancelled the sign-in process, handle accordingly
      return null;
    }

    // obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    //create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    //finall signin
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
