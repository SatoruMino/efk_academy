import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  const Cart({
    required this.id,
    required this.userId,
    required this.courseId,
    this.courseName,
    this.coursePrice,
    this.courseDiscount,
    this.courseImageUrl,
  });

  final String id;
  final String userId;
  final String courseId;
  final String? courseName;
  final double? coursePrice;
  final double? courseDiscount;
  final String? courseImageUrl;

  @override
  List<Object?> get props => [id, userId, courseId];
}
