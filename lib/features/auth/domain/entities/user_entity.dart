class UserEntity {
  final String uid;
  final String name;
  final String email;
  String role;

  UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
  });
}
