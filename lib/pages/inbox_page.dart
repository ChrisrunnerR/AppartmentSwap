import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signin/services/firestore.dart';
// Import your FireStoreService

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  String userId = "";
  String firstName = "";
  String lastName = "";

  @override
  void initState() {
    super.initState();
    final fireStoreService =
        FireStoreService(); // Instance of your Firestore service
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          userId = user.uid;
        });
        // Fetch additional user details
        fireStoreService.getUserProfile(user.uid).then((userData) {
          if (userData != null) {
            setState(() {
              firstName = userData['firstName'] ?? "";
              lastName = userData['lastName'] ?? "";
            });
          }
        });
      } else {
        setState(() {
          userId = "No user logged in";
          firstName = "";
          lastName = "";
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
        child: userId.isEmpty
            ? const Text("No user logged in")
            : Text("User ID: $userId\nName: $firstName $lastName"),
      ),
    );
  }
}
