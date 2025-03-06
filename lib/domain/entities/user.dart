class User {
  const User({
    required this.id,
    required this.username,
    required this.updatedAt,
  });

  final String id;
  final String username;
  final DateTime? updatedAt;
}
