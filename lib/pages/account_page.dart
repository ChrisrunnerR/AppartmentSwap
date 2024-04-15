// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signin/components/account_page/edit_profile_page.dart';
import 'package:signin/components/account_page/profile_card.dart';

class AccountPage extends StatefulWidget {
  AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final user = FirebaseAuth.instance.currentUser;

  void _editProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfilePage()),
    );
  }

  void _deleteAccount() {
    // Logic for deleting an account
  }

  void signUserOut() {
    try {
      FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app), // Icon for signing out
            onPressed: signUserOut, // Function to execute on pressing the icon
            tooltip:
                'Sign Out', // Optional: Adds a small description when long pressed
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 20.0),
            child: ProfileCard(
              onPressed: _editProfile,
            ), // Directly placing ProfileCard here
          ),
        ],
      ),
    );
  }
}
