// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:signin/components/continue_with.dart';
import 'package:signin/components/my_button.dart';
import 'package:signin/components/my_textfield.dart';
import 'package:signin/components/square_tile.dart';
import 'package:signin/services/auth_service.dart';
import 'package:signin/services/firestore.dart';

class RegisterPage extends StatefulWidget {
  Function()? onTap;
  RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  FireStoreService firestoreService = FireStoreService();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmedPasswordController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the controllers when the state is de-allocated.
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmedPasswordController.dispose();
    super.dispose(); // Always call super.dispose() last.
  }

  void signUserUp() async {
    if (passwordController.text != confirmedPasswordController.text) {
      showErrorMessage("Passwords don't match!");
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      User? newUser = userCredential.user;
      if (newUser != null) {
        await firestoreService.createUserProfile(
          newUser, // Pass the User object
          firstNameController.text.trim(),
          lastNameController.text.trim(),
          // Add additional fields if needed, e.g., profileImageUrl
        );
        Navigator.pop(context); // Dismiss the loading indicator
        // Optionally, navigate to another page or show a success message
      } else {
        Navigator.pop(context); // Dismiss the loading indicator
        showErrorMessage("Failed to create user profile.");
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Always dismiss the loading indicator
      showErrorMessage(e.message ?? "An error occurred during sign up.");
    }
  }

// // Firestore DB
//   Future addUserDetails(
//     user, // do i need this ?
//     context, // do i need this ?
//     int userID,
//     String firstname,
//     String lastname,
//     String email,
//   ) async {
//     await FirebaseFirestore.instance.collection("user").add({
//       'uid': userID,
//       'firstName': firstname,
//       'lastName': lastname,
//       'email': email,
//     });
//   }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 240, 152, 182),
          title: Center(
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                //logo
                Icon(
                  Icons.airplanemode_active_sharp,
                  size: 50,
                ),
                const SizedBox(height: 25),
                //welcoem back
                Text(
                  "Welcome Please Fill Out Your Information",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                // First Name
                MyTextField(
                  controller: firstNameController,
                  hintText: 'First Name',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: lastNameController,
                  hintText: 'Last Name',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                //email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                //password
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: confirmedPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                //forgot password ?
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Text("Forgot Password?",
                      //     style: TextStyle(
                      //       color: Colors.grey[600],
                      //     )),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                //sign in/ signUp button
                MyButton(
                  text: "Sign Up",
                  onTap: signUserUp,
                ),
                const SizedBox(height: 25),

                //continwith with
                ContinueWith(),
                const SizedBox(height: 25),
                //google + apple sign in
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                        onTap: () => AuthService().signInWithGoogle(),
                        imagePath: "lib/images/google.jpg"),
                    const SizedBox(width: 10),
                    // SquareTile(
                    //   //need to add in apple
                    //   onTap: () {},
                    //   imagePath: "lib/images/apple.jpg",
                    // ),
                  ],
                ),

                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",
                        style: TextStyle(
                          color: Colors.grey[700],
                        )),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login now",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
                // not a member ? register now
              ],
            ),
          ),
        ),
      ),
    );
  }
}
