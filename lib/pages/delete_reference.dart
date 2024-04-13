/* 

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Page"),
      ),
      body: user != null ? _buildUserInfo(user) : _buildNoUserSignedIn(),
    );
  }

  Widget _buildUserInfo(User user) {
    final name = user.displayName ?? "No name available";
    final email = user.email ?? "No email available";
    final photoUrl = user.photoURL ?? "https://via.placeholder.com/150";
    final emailVerified = user.emailVerified;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(photoUrl),
            radius: 50,
          ),
          SizedBox(height: 20),
          Text("Name: $name"),
          SizedBox(height: 10),
          Text("Email: $email"),
          SizedBox(height: 10),
          Text("Email verified: ${emailVerified ? "Yes" : "No"}"),
        ],
      ),
    );
  }

  Widget _buildNoUserSignedIn() {
    return Center(
      child: Text("No user is currently signed in."),
    );
  }
}


*/