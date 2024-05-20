import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redqteam/auth/mail_verification/button.dart';
import 'package:redqteam/auth/mail_verification/controller/mail_verification_controller.dart';

class MailVerificationView extends StatefulWidget {
  const MailVerificationView({super.key});

  @override
  State<MailVerificationView> createState() => _MailVerificationViewState();
}

class _MailVerificationViewState extends State<MailVerificationView> {
  @override
  void initState() {
    MailVerificationController().sendVerificationEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100, left: 20, bottom: 0, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.mail_lock_outlined,
                size: 100,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                "Verify your email address",
                style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.headlineSmall),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "We have sent a verification mail. Click on the verification link contained in it to verify you email id. Once verified, click on continue button below.",
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              const MailVeriButton()
            ],
          ),
        ),
      ),
    );
  }
}
