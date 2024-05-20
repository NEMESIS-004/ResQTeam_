import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:redqteam/components/text_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/loading_error.dart';
import 'controller/forget_password_controller.dart';

class ForgotPasswordView extends ConsumerWidget {
  const ForgotPasswordView({super.key});

  String _getButtonText(FormzStatus status) {
    if (status.isSubmissionInProgress) {
      return "Requesting..";
    } else if (status.isSubmissionFailure) {
      return "Failed";
    } else if (status.isSubmissionSuccess) {
      return "Done";
    } else {
      return "request";
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forgotPasswordState = ref.watch(forgotPasswordProvider);
    final status = forgotPasswordState.status;

    ref.listen<ForgetPasswordState>(forgotPasswordProvider,
        (previous, current) {
      if (current.status.isSubmissionFailure) {
        Navigator.of(context).pop();
        ErrorDialog.show(context, "${current.errorMessage}");
      }
    });
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextInputField(
              hintText: "Please Enter Your Email",
              onChanged: (email) {
                ref.read(forgotPasswordProvider.notifier).onEmailChange(email);
              }),
          Row(
            children: [
              TextButton(
                  onPressed: status.isSubmissionInProgress
                      ? null
                      : () {
                          Navigator.of(context).pop();
                        },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: status.isSubmissionInProgress ||
                          status.isSubmissionSuccess
                      ? null
                      : () {
                          ref
                              .read(forgotPasswordProvider.notifier)
                              .forgotPassword();
                        },
                  child: Text(_getButtonText(status)))
            ],
          )
        ],
      ),
    );
  }
}
