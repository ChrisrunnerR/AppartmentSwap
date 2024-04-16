import 'package:flutter/material.dart';
import 'package:signin/pages/account_page.dart';
import 'package:signin/pages/home_page.dart';
import 'package:signin/pages/inbox_page.dart';
import 'package:signin/pages/saved_vacay.dart';
//delete
import 'package:signin/pages/delete_reference.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int selectedPage = 0;

  final _pageOptions = [
    HomePage(),
    SavedVacay(),
    InboxPage(),
    TrashPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pageOptions[selectedPage],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Container(
          //   margin: EdgeInsets.zero, // Remove any default margin
          //   padding: EdgeInsets.zero, // Remove any default padding
          //   child: const Divider(
          //     color: Color.fromARGB(255, 194, 190, 190),
          //     thickness: 0.5,
          //   ),
          // ),
          BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.house, size: 30),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite, size: 30),
                label: 'Saved',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.inbox_outlined, size: 30),
                label: 'Messages',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.access_time, size: 30),
                label: 'Trash',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, size: 30),
                label: 'Account',
              ),
            ],
            selectedItemColor: Colors.green,
            elevation: 0.0,
            unselectedItemColor: Colors.green[900],
            currentIndex: selectedPage,
            backgroundColor: Colors.white,
            showUnselectedLabels: true, // Show labels for all items
            onTap: (index) {
              setState(() {
                selectedPage = index;
              });
            },
          ),
        ],
      ),
    );
  }
}
