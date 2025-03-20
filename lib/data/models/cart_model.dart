import 'package:efk_academy/domain/domain.dart';

class CartModel extends Cart {
  const CartModel({
    required super.id,
    required super.userId,
    required super.courseId,
    super.courseName,
    super.coursePrice,
    super.courseDiscount,
    super.courseImageUrl,
  });

  factory CartModel.fromJson(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'] ?? '',
      userId: map['user_id'] ?? '',
      courseId: map['course_id'] ?? '',
      courseName: map['courses']['name'] ?? '',
      coursePrice: (map['courses']['price'] as num).toDouble(),
      courseImageUrl: map['courses']['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'course_id': courseId,
    };
  }

  CartModel copyWith({
    String? id,
    String? userId,
    String? courseId,
  }) {
    return CartModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      courseId: courseId ?? this.courseId,
    );
  }
}
