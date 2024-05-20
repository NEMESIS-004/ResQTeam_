// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redqteam/auth/form_validators/aadhar_validator.dart';

import '../../components/text_input.dart';
import 'controller/signup_controller.dart';

class AadharField extends ConsumerWidget {
  const AadharField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignUpState = ref.watch(signUpProvider);
    final showError = SignUpState.aadhar.invalid;
    final SignUpController = ref.read(signUpProvider.notifier);
    return TextInputField(
      hintText: "Aadhar Number",
      icon: const Icon(Icons.call_to_action_rounded),
      errorText: showError
          ? AadharNumber.showAadharValidationError(SignUpState.aadhar.error)
          : null,
      onChanged: (aadharNumber) =>
          SignUpController.onAadharChange(aadharNumber),
    );
  }
}
