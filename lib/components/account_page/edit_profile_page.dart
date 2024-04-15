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
  File? _selectedImage; // Variable to store the selected image
  final User? user = FirebaseAuth.instance.currentUser; // Get current user

  Future<void> _pickImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? returnedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    // Check if an image is selected
    if (returnedImage != null) {
      setState(() {
        _selectedImage =
            File(returnedImage.path); // Update the UI with the selected image
      });
    }
  }

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;
    if (_selectedImage != null) {
      imageProvider = FileImage(_selectedImage!); // Use the uploaded image
    } else if (user?.photoURL != null) {
      imageProvider = NetworkImage(user!.photoURL!); // Use Firebase photoURL
    } else {
      imageProvider =
          AssetImage('images/default_pfp.jpg'); // Use a default image
    }
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
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: imageProvider,
                ),
                // child: CircleAvatar(
                //   radius: 40,
                //   backgroundImage: user?.photoURL != null
                //       ? NetworkImage(user!.photoURL!)
                //       : const AssetImage('images/default_pfp.jpg')
                //           as ImageProvider,
                // ),
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
