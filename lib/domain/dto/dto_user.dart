class DTOUser {
  dynamic id;
  final String name;
  final String email;
  String? status;
  final String password;
  DTOUser(
      {this.id,
      required this.name,
      required this.email,
      this.status,
      required this.password});
}
