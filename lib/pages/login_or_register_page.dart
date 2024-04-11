import 'package:flutter/material.dart';
import 'package:signin/pages/login_page.dart';
import 'package:signin/pages/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  // initially show login page at the begining
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  bool showLoginPage = true;
  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}
