// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//await FirebaseFirestore.instance.collection("users")

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  ImagePicker imagePicker = ImagePicker();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

// need to remove this
  Future<void> _updateProfile() async {
    if (user != null) {
      try {
        // Update the user's display name in Firebase
        await user!.updateDisplayName(
            '${firstNameController.text.trim()} ${lastNameController.text.trim()}');
        await user!
            .reload(); // Reload user data to ensure the update is reflected
      } catch (error) {
        print('Failed to update profile: $error');
      }
    }
    Navigator.of(context).pop();
  }

  Future<void> _updateProfilePicture() async {
    // Step 1: Pick an image from the gallery
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Step 2: Upload the image to Firebase Storage
      File file = File(image.path);
      try {
        String uploadPath = 'user_images/${user?.uid}/${image.name}';
        UploadTask uploadTask =
            FirebaseStorage.instance.ref(uploadPath).putFile(file);
        TaskSnapshot snapshot = await uploadTask;
        String imageUrl = await snapshot.ref.getDownloadURL();

        // Step 3: Update the image URL in Firebase Auth (Optional)
        await user?.updatePhotoURL(imageUrl);

        // Step 4: Update the image URL in Firestore
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user?.uid)
            .set({
          'photoURL': imageUrl,
        }, SetOptions(merge: true));

        setState(() {
          // Refresh UI to display the updated image
        });
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _updateProfilePicture,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: user?.photoURL != null
                      ? NetworkImage(user!.photoURL!)
                      : const AssetImage('images/default_pfp.jpg')
                          as ImageProvider,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Update Profile Picture",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _updateProfile,
                child: Text('Update Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
