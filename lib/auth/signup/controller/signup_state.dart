part of "signup_controller.dart";

class SignUpState extends Equatable {
  final Name name;
  final Email email;
  final Password password;
  final AadharNumber aadhar;
  final String role;
  final FormzStatus status;
  final String? errorMessage;

  const SignUpState({
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.aadhar = const AadharNumber.pure(),
    this.role = "user",
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  SignUpState copyWith({
    Name? name,
    Email? email,
    Password? password,
    AadharNumber? aadhar,
    String? role,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      aadhar: aadhar ?? this.aadhar,
      role: role ?? this.role,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        aadhar,
        role,
        status,
      ];
}
