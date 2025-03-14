import 'package:efk_academy/domain/entities/course.dart';

class CourseModel extends Course {
  const CourseModel({
    required super.id,
    required super.name,
    required super.price,
    required super.discount,
    required super.summary,
    required super.description,
    required super.previewVideoId,
    required super.imageUrl,
  });

  factory CourseModel.fromJson(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      price: (map['price'] as num).toDouble(),
      discount: (map['discount'] as num).toDouble(),
      summary: map['summary'] ?? '',
      description: map['description'] ?? '',
      previewVideoId: map['preview_video_id'] ?? '',
      imageUrl: map['image_url'] ?? '',
    );
  }
}
