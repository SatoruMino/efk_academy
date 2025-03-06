import 'package:efk_academy/domain/entities/review.dart';

class ReviewModel extends Review {
  ReviewModel({
    required super.id,
    required super.username,
    required super.message,
    required super.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> map) {
    return ReviewModel(
      id: map['id'] ?? '',
      username: map['username'] ?? '',
      message: map['message'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}
