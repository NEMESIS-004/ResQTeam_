// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redqteam/auth/form_validators/password_validator.dart';

import '../../components/text_input.dart';
import 'controller/signup_controller.dart';

class PasswordField extends ConsumerWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignUpState = ref.watch(signUpProvider);
    final showError = SignUpState.password.invalid;
    final SignUpController = ref.read(signUpProvider.notifier);
    return TextInputField(
      obscureText: true,
      hintText: "Password",
      icon: const Icon(Icons.key),
      errorText: showError
          ? Password.showPasswordErrorMessage(SignUpState.password.error)
          : null,
      onChanged: (pswd) => SignUpController.onPasswordChange(pswd),
    );
  }
}
