class UserLoginRequestDTO {
  final String username;
  final String password;
  final String clientName;
  final String clientSecret;
  final String deviceUUID;

  UserLoginRequestDTO(
      {this.username,
      this.password,
      this.clientName,
      this.clientSecret,
      this.deviceUUID});
}
