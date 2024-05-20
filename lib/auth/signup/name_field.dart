// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redqteam/auth/signup/controller/signup_controller.dart';
import '../../components/text_input.dart';
import '../form_validators/name_validator.dart';

class NameField extends ConsumerWidget {
  const NameField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignUpState = ref.watch(signUpProvider);
    final showError = SignUpState.name.invalid;
    final SignUpController = ref.read(signUpProvider.notifier);
    return TextInputField(
      hintText: "Name",
      icon: const Icon(Icons.person),
      errorText:
          showError ? Name.showNameErrorMessage(SignUpState.name.error) : null,
      onChanged: (name) => SignUpController.onNameChange(name),
    );
  }
}
