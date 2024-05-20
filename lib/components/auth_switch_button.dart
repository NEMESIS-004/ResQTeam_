import 'package:flutter/material.dart';
import '../components/slide_fade_switcher.dart';

class AuthSwitchButton extends StatelessWidget {
  final bool showSignIn;
  final VoidCallback onTap;
  const AuthSwitchButton(
      {super.key, required this.showSignIn, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 30,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
            child: showSignIn
                ? SlideFadeSwitcher(
                    child: Text(
                      "Don't have account? Sign Up",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5)),
                      key: const ValueKey("SignIn"),
                    ),
                  )
                : SlideFadeSwitcher(
                    child: Text(
                      "Already have account? Sign In",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5)),
                      key: const ValueKey("SignUP"),
                    ),
                  )),
      ),
    );
  }
}
