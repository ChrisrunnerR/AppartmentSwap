// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SavedVacay extends StatefulWidget {
  const SavedVacay({super.key});

  @override
  State<SavedVacay> createState() => _SavedVacayState();
}

class _SavedVacayState extends State<SavedVacay> {
  static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
      initialCameraPosition: CameraPosition(
        target: _pGooglePlex,
        zoom: 13,
      ),
    ));
  }
}
