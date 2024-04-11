// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signin/components/search_bar.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Search",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: const Color.fromARGB(255, 194, 190, 190),
            thickness: .5, // Set the thickness of the divider
          ),
        ),
      ),
      // SearchBarDest(),
      body: SearchBarDest(),
    );
  }
}
