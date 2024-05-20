// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/text_input.dart';
import '../form_validators/email_validator.dart';
import 'controller/signup_controller.dart';

class EmailField extends ConsumerWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignUpState = ref.watch(signUpProvider);
    final showError = SignUpState.email.invalid;
    final SignUpController = ref.read(signUpProvider.notifier);
    return TextInputField(
      hintText: "Email",
      icon: const Icon(Icons.mail),
      errorText: showError
          ? Email.showEmailErrorMessage(SignUpState.email.error)
          : null,
      onChanged: (email) => SignUpController.onEmailChange(email),
    );
  }
}
