import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapButton extends StatefulWidget {
  void Function()? onPressed;
  MapButton({super.key});

  @override
  State<MapButton> createState() => _MapButtonState();
}

class _MapButtonState extends State<MapButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Center(
            child: ElevatedButton(
              onPressed: () => _showMapModal(context),
              child: const Text("Map"),
            ),
          ),
        ),
      ],
    );
  }
}

void _showMapModal(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    enableDrag: true,
    isDismissible: true,
    context: context,
    backgroundColor: Colors.transparent, // Make modal background transparent
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.9,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white, // Apply color here within decoration
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(25)), // Match modal shape
          ),
        ),
      );
    },
  );
}
