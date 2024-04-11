// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class SearchBarDest extends StatelessWidget {
  SearchBarDest({super.key});

  final Color appGrey = Color(0xFFA0A0A0);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.0,
      child: Stack(
        children: [
          Positioned(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color.fromARGB(255, 194, 190, 190),
                  width: .5,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    size: 30.0,
                    color: Colors.indigo,
                  ),
                  const SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Where do you want to go?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
