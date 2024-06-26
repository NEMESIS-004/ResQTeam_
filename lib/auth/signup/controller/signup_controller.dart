import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:redqteam/auth/form_validators/aadhar_validator.dart';
import '../../../../../repository/auth_repo_provider.dart';
import 'package:authentication_repository/authentication_repository.dart';

import '../../form_validators/email_validator.dart';
import '../../form_validators/name_validator.dart';
import '../../form_validators/password_validator.dart';

part 'signup_state.dart';

final signUpProvider =
    StateNotifierProvider.autoDispose<SignUpController, SignUpState>(
  (ref) => SignUpController(ref.watch(authRepoProvider)),
);

class SignUpController extends StateNotifier<SignUpState> {
  final AuthenticationRepository _authenticationRepository;
  SignUpController(this._authenticationRepository) : super(const SignUpState());

  void onNameChange(String value) {
    final name = Name.dirty(value);
    state = state.copyWith(
      name: name,
      status: Formz.validate([
        name,
        state.email,
        state.password,
        state.aadhar,
      ]),
    );
  }

  void onEmailChange(String value) {
    final email = Email.dirty(value);

    state = state.copyWith(
      email: email,
      status: Formz.validate(
        [
          state.name,
          email,
          state.password,
          state.aadhar,
        ],
      ),
    );
  }

  void onPasswordChange(String value) {
    final password = Password.dirty(value);
    state = state.copyWith(
      password: password,
      status: Formz.validate(
        [state.name, state.email, password, state.aadhar],
      ),
    );
  }

  void onAadharChange(String value) {
    final aadhar = AadharNumber.dirty(value);
    state = state.copyWith(
      aadhar: aadhar,
      status: Formz.validate(
        [
          state.name,
          state.email,
          state.password,
          aadhar,
        ],
      ),
    );
  }

  void onRoleChange(String value) {
    state = state.copyWith(
        role: value,
        status: Formz.validate([
          state.name,
          state.email,
          state.password,
          state.aadhar,
        ]));
  }

  void signUpWithEmailAndPassword() async {
    if (!state.status.isValidated) return;
    state = state.copyWith(status: FormzStatus.submissionInProgress);
    try {
      await _authenticationRepository.signUpWithEmailAndPassword(
        name: state.name.value,
        email: state.email.value,
        password: state.password.value,
      );

      state = state.copyWith(status: FormzStatus.submissionSuccess);
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      state = state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.code);
    }
  }
}
