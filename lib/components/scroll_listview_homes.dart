// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:signin/components/map_button.dart';
import 'package:signin/components/search_bar.dart';

class ScrollViewHomes extends StatelessWidget {
  const ScrollViewHomes({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SearchBarDest(),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      color: Colors.deepPurple[200],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      color: Colors.deepPurple[200],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      color: Colors.deepPurple[200],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      color: Colors.deepPurple[200],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        //add on rand component
        MapButton(),
      ],
    );
  }
}
