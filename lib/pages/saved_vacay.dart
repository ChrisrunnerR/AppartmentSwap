// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SavedVacay extends StatefulWidget {
  const SavedVacay({super.key});

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
        body: Center(
          child: Text("saved page "),
        ));
  }
}
