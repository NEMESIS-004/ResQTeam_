// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../components/auth_switch_button.dart';
import './signin/signin.dart';
import './signup/signup.dart';
import '../components/slide_fade_switcher.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool _showSignIn = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(16, 100, 16, 0),
            child: SlideFadeSwitcher(child: _showSignIn ? SignIn() : SignUp())),
        AuthSwitchButton(
            showSignIn: _showSignIn,
            onTap: () {
              setState(() {
                _showSignIn = !_showSignIn;
              });
            })
      ]),
    );
  }
}
