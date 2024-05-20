// ignore_for_file: avoid_print

import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';

class MailVerificationController {
  Future<void> sendVerificationEmail() async {
    try {
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
    } catch (e) {
      print(e);
    }
  }

  bool manualCheck() {
    FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;
    if (user!.emailVerified) {
      return true;
    } else {
      return false;
    }
  }
}
