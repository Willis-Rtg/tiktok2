class SignupFormModel {
  final String email;
  final String password;
  final String username;
  final DateTime? birthday;

  const SignupFormModel({
    required this.email,
    required this.password,
    required this.username,
    required this.birthday,
  });
}
