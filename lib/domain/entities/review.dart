class Review {
  const Review({
    required this.id,
    required this.username,
    required this.message,
    required this.createdAt,
  });

  final String id;
  final String username;
  final String message;
  final DateTime createdAt;
}
