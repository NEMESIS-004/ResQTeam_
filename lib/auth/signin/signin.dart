import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'email_field.dart';
import 'button.dart';
import 'password_field.dart';
import 'forget_password_button.dart';
import 'divider_signin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/loading_error.dart';
import 'controller/signin_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignIn extends ConsumerWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(signInProvider, (previous, current) {
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
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          'assets/svg/signin_image.svg',
          height: 200,
          width: 200,
        ),
        const SizedBox(
          height: 25,
        ),
        const EmailField(),
        const SizedBox(
          height: 16,
        ),
        const PasswordField(),
        const ForgetPasswordButton(),
        const SizedBox(
          height: 16,
        ),
        const SignInButton(),
        const DividerSignIn(),
      ],
    );
  }
}
