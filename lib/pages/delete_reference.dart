import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TrashPage extends StatefulWidget {
  TrashPage({Key? key}) : super(key: key);

  @override
  State<TrashPage> createState() => _TrashPageState();
}

class _TrashPageState extends State<TrashPage> {
  File? _image;
  String? _imageUrl;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserImage();
  }

  // Function to handle the file selection
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _uploadFile();
    }
  }

  // Function to upload file to Firebase Storage
  Future<void> _uploadFile() async {
    if (_image == null) return;

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User not logged in");
      return;
    }
    String filePath = 'userPhotos/${user.uid}/${DateTime.now()}.png';
    try {
      TaskSnapshot snapshot =
          await FirebaseStorage.instance.ref(filePath).putFile(_image!);
      String url = await snapshot.ref.getDownloadURL();
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'profileImageUrl': url});
      setState(() {
        _imageUrl = url;
      });
    } catch (e) {
      print('Error occurred while uploading to Firebase: $e');
    }
  }

  // Load user image from Firestore
  void _loadUserImage() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userDoc.exists && userDoc.data() != null) {
        setState(() {
          _imageUrl =
              (userDoc.data() as Map<String, dynamic>)['profileImageUrl'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage:
                  _imageUrl != null ? NetworkImage(_imageUrl!) : null,
              child: _image == null && _imageUrl == null
                  ? IconButton(
                      icon: Icon(Icons.add_a_photo),
                      onPressed: _pickImage,
                    )
                  : null,
            ),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text("Upload Photo"),
            )
          ],
        ),
      ),
    );
  }
}
