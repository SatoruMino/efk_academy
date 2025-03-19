import 'package:efk_academy/core/core.dart';

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

  String get createdDate => findDateAgo(createdAt);
}
