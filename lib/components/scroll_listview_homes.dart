import 'package:flutter/material.dart';
import 'package:signin/components/search_bar.dart';

class ScrollViewHomes extends StatelessWidget {
  const ScrollViewHomes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
