// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SavedVacay extends StatefulWidget {
  const SavedVacay({super.key});

  @override
  State<SavedVacay> createState() => _SavedVacayState();
}

class _SavedVacayState extends State<SavedVacay> {
  File? _selectedImage; // Variable to store the selected image
  final User? user = FirebaseAuth.instance.currentUser; // Get current user

  Future<void> _pickImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? returnedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    // Check if an image is selected
    if (returnedImage != null) {
      File imageFile = File(returnedImage.path);
      setState(() {
        _selectedImage = imageFile; // Update the UI with the selected image
      });
      await _uploadImageToFirebase(
          imageFile); // Upload the image and update the profile
    }
  }

  Future<void> _uploadImageToFirebase(File imageFile) async {
    try {
      String filePath = 'user_images/${user!.uid}/profile_pic.jpg';
      UploadTask uploadTask =
          FirebaseStorage.instance.ref().child(filePath).putFile(imageFile);

      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      _updateUserPhotoUrl(imageUrl); // Update user's profile with new image URL
    } catch (e) {
      print("Error uploading image: $e"); // Handle errors here
    }
  }

  Future<void> _updateUserPhotoUrl(String imageUrl) async {
    try {
      await user!.updatePhotoURL(imageUrl);
      setState(() {}); // Update the UI after changing the user's photo URL
    } catch (e) {
      print("Failed to update the user's profile picture: $e");
    }
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
          AssetImage('lib/images/default_pfp.jpeg'); // Use a default image
    }

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: _pickImageFromGallery,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: imageProvider,
              ),
            ),
            SizedBox(height: 20),
            _selectedImage == null
                ? Text("No image selected")
                : Image.file(_selectedImage!, width: 200, height: 200),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _pickImageFromGallery,
        label: Text("Upload Image"),
        icon: Icon(Icons.cloud_upload),
      ),
    );
  }
}
