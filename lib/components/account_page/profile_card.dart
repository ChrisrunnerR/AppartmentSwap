import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signin/services/firestore.dart'; // Correct import statement, ensure it is imported once

class ProfileCard extends StatefulWidget {
  final Function()? onPressed;

  const ProfileCard({super.key, this.onPressed});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>?
      userProfile; // To store user profile data from Firestore

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  fetchUserProfile() async {
    if (user != null) {
      // Using a local non-nullable user variable ensures we can use it safely
      var profileData = await FireStoreService().getUserProfile(user!.uid);
      if (profileData != null) {
        setState(() {
          userProfile = profileData;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Handling possible null values in display name and image URL
    String displayName =
        userProfile?['firstName'] ?? userProfile?['lastName'] ?? 'User Name';
    String imageUrl =
        userProfile?['profileImageUrl'] ?? 'lib/images/default_pfp.jpeg';

    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(imageUrl),
        ),
        const SizedBox(width: 10), // Space between the image and the text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    displayName, // Use the user's name from Firestore
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: widget.onPressed,
                    child:
                        const Text('Edit', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
              const Text("Update account",
                  style: TextStyle(fontSize: 16, color: Colors.grey))
            ],
          ),
        ),
      ],
    );
  }
}
