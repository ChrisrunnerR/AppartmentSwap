import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:signin/components/scroll_listview_homes.dart';
import 'package:signin/components/search_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _pGooglePlex,
              zoom: 13,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top +
                10, // Adjust for status bar height + 10px padding
            left: 0,
            right: 0,
            child: SearchBarDest(), // Assuming this is your search bar widget
          ),
        ],
      ),
    );
  }
}
