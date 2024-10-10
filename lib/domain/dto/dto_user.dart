class DTOUser {
  dynamic id;
  final String name;
  final String email;
  final String status;
  final String password;
  DTOUser(
      {this.id,
      required this.name,
      required this.email,
      required this.status,
      required this.password});
}
