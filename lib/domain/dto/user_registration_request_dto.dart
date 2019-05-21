class UserRegistrationDTO {
  final String email;
  final String username;
  final String password;
  final String passwordConfirmation;
  final String clientName;
  final String clientSecret;

  UserRegistrationDTO(
      {this.email,
      this.username,
      this.password,
      this.passwordConfirmation,
      this.clientName,
      this.clientSecret});
}
