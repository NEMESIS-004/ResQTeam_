import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redqteam/auth/form_validators/password_validator.dart';

import '../../components/text_input.dart';
import 'controller/signin_controller.dart';

class PasswordField extends ConsumerWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInState = ref.watch(signInProvider);
    final bool showError = signInState.password.invalid;
    final signInController = ref.read(signInProvider.notifier);
    return TextInputField(
      obscureText: true,
      hintText: "Password",
      icon: const Icon(Icons.key),
      errorText: showError
          ? Password.showPasswordErrorMessage(signInState.password.error)
          : null,
      onChanged: (pswd) => signInController.onPasswordChange(pswd),
    );
  }
}
