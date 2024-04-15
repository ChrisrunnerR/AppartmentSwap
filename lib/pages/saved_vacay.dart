import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SavedVacay extends StatefulWidget {
  const SavedVacay({super.key});

  @override
  State<SavedVacay> createState() => _SavedVacayState();
}

class _SavedVacayState extends State<SavedVacay> {
  File? _image; // This will hold the image file

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path); // Set the _image to the selected image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_image != null) // Display the selected image if available
              Image.file(_image!,
                  width: double.infinity, height: 300, fit: BoxFit.cover),
            ElevatedButton(
              onPressed:
                  _pickImage, // Call _pickImage when the button is pressed
              child: const Text("Pick Image from Gallery"),
            ),
          ],
        ),
      ),
    );
  }
}
