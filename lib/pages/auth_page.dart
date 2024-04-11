// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signin/pages/home_page.dart';
import 'package:signin/pages/login_or_register_page.dart';
import 'package:signin/pages/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          // this is always looking to see if user is logged in or not
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //user is logged in
            if (snapshot.hasData) {
              return HomePage();
            }
            //user isnt logged in
            else {
              return LoginOrRegisterPage();
            }
          }),
    );
  }
}
