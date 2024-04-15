// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:signin/services/firestore.dart';

class SavedVacay extends StatefulWidget {
  FireStoreService firestoreService = FireStoreService();
  SavedVacay({super.key});

  @override
  State<SavedVacay> createState() => _SavedVacayState();
}

class _SavedVacayState extends State<SavedVacay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Saved",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            widget.firestoreService.getUserStream(), // Accessing through widget
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); // Show loading indicator
          }
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}"); // Display error message
          }
          if (!snapshot.hasData) {
            return Text("No data available"); // No data message
          }
          List<DocumentSnapshot> notesList = snapshot.data!.docs;
          return ListView.builder(
            itemCount: notesList.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = notesList[index];
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              // Extract first name and last name safely with fallbacks
              String firstName = data['fname'] ?? 'No first name';
              String lastName = data['lname'] ?? 'No last name';

              // Concatenate first name and last name
              String fullName = '$firstName $lastName';

              // Display as ListTile with full name
              return ListTile(
                title: Text(fullName),
              );
            },
          );
        },
      ),
    );
  }
}

// display current user 