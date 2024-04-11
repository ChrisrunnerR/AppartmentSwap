// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:signin/pages/account_page.dart';
import 'package:signin/pages/home_page.dart';
import 'package:signin/pages/inbox_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int selectedPage = 0;

  final _pageOptions = [
    HomePage(),
    InboxPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: _pageOptions[selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30),
                label: 'Home'), // Changed 'title' to 'label'
            BottomNavigationBarItem(
                icon: Icon(Icons.mail, size: 30),
                label: 'Inbox'), // Changed 'title' to 'label'
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, size: 30),
                label: 'Account'), // Changed 'title' to 'label'
          ],
          selectedItemColor: Colors.green,
          elevation: 5.0,
          unselectedItemColor: Colors.green[900],
          currentIndex: selectedPage,
          backgroundColor: Colors.white,
          onTap: (index) {
            setState(() {
              selectedPage = index;
            });
          },
        ));
  }
}
