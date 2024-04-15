import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  String userId = "";

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          userId = user.uid; // Update the userId with the current user's UID
        });
        print(userId); // This will print the user UID to your debug console
      } else {
        setState(() {
          userId = "No user logged in"; // Reset or handle a logged-out scenario
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Messages",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        // Display the user ID or the message "No user logged in"
        child: Text(userId.isEmpty ? "No user logged in" : "User ID: $userId"),
      ),
    );
  }
}
