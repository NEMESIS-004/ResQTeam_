import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:redqteam/auth/signin/divider_signin.dart';
import 'package:redqteam/auth/signup/aadhar_field.dart';
import 'package:redqteam/auth/signup/role_selector.dart';
import 'name_field.dart';
import 'email_field.dart';
import 'password_field.dart';
import 'button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'controller/signup_controller.dart';
import '../../components/loading_error.dart';

class SignUp extends ConsumerWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SignUpState>(signUpProvider, (previous, current) {
      if (current.status.isSubmissionInProgress) {
        LoadingSheet.show(context);
      } else if (current.status.isSubmissionFailure) {
        Navigator.of(context).pop();
        ErrorDialog.show(context, "${current.errorMessage}");
      } else if (current.status.isSubmissionSuccess) {
        Navigator.of(context).pop();
      }
    });
    return Column(
      children: [
        SvgPicture.asset(
          'assets/svg/signup_image.svg',
          height: 200,
          width: 200,
        ),
        const SizedBox(
          height: 20,
        ),
        const NameField(),
        const SizedBox(
          height: 16,
        ),
        const AadharField(),
        const SizedBox(
          height: 16,
        ),
        const EmailField(),
        const SizedBox(
          height: 16,
        ),
        const PasswordField(),
        const SizedBox(
          height: 16,
        ),
        RoleSelector(),
        const SizedBox(
          height: 24,
        ),
        const SignUpButton(),
        const DividerSignIn(),
      ],
    );
  }
}
