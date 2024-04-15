// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatefulWidget {
  final Function()? onPressed;

  const ProfileCard({super.key, this.onPressed});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40, // Adjust the size as needed
          backgroundImage: user?.photoURL != null
              ? NetworkImage(user!.photoURL!)
              : const AssetImage('lib/images/default_pfp.jpeg')
                  as ImageProvider, // Fallback to a local asset image
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
                    user?.displayName ??
                        "User Name", // Use the user's name, or a placeholder
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //yeah need to figure this out
                  TextButton(
                    onPressed: widget.onPressed,
                    child: Text('Edit', style: TextStyle(color: Colors.red)),
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
