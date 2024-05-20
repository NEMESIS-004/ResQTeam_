// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:redqteam/auth/signup/controller/signup_controller.dart';

import '../../components/animated_button.dart';
import '../../components/rounded_button_style.dart';

class SignUpButton extends ConsumerWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpState = ref.watch(signUpProvider);
    final SignUpController = ref.read(signUpProvider.notifier);
    final bool isValidated = signUpState.status.isValidated;
    return CustomAnimatedButton(
        onTap: isValidated
            ? () => SignUpController.signUpWithEmailAndPassword()
            : null,
        child: const RoundedButtonStyle(
          title: "Sign Up",
        ));
  }
}
