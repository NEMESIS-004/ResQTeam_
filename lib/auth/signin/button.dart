import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../components/animated_button.dart';
import '../../components/rounded_button_style.dart';
import 'controller/signin_controller.dart';

class SignInButton extends ConsumerWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInState = ref.watch(signInProvider);
    final bool isValidated = signInState.status.isValidated;
    final signInController = ref.read(signInProvider.notifier);
    return CustomAnimatedButton(
        onTap: isValidated
            ? () => signInController.signInWithEmailAndPassword()
            : null,
        child: const RoundedButtonStyle(
          title: "Sign In",
        ));
  }
}
