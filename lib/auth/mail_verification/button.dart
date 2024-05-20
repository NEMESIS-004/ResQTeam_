import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redqteam/auth/mail_verification/controller/mail_verification_controller.dart';
import 'package:redqteam/components/loading_error.dart';

import '../../components/animated_button.dart';
import '../../components/rounded_button_style.dart';
import '../signup/controller/signup_controller.dart';

class MailVeriButton extends ConsumerWidget {
  const MailVeriButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpState = ref.watch(signUpProvider);
    return CustomAnimatedButton(
        onTap: () {
          if (MailVerificationController().manualCheck()) {
            if (signUpState.role == 'admin') {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/adminform', (route) => false);
            } else if (signUpState.role == 'user') {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/userform', (route) => false);
            }
          } else {
            ErrorDialog.show(
                context, "Mail Not yet verified, Plase try again!");
          }
        },
        child: const RoundedButtonStyle(
          title: "Continue",
        ));
  }
}
