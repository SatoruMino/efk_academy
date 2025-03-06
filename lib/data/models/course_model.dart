import 'package:efk_academy/domain/entities/course.dart';

class CourseModel extends Course {
  CourseModel({
    required super.id,
    required super.name,
    required super.price,
    required super.discount,
    required super.summary,
    required super.description,
    required super.previewVideoId,
    required super.imageUrl,
    required super.sections,
    required super.instructorName,
    required super.instructorTitle,
    required super.instructorBio,
    required super.isEnrolled,
  });

  static CourseModel fromJson(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      price: (map['price'] as num).toDouble(),
      discount: (map['discount'] as num).toDouble(),
      summary: map['summary'] ?? '',
      description: map['description'] ?? '',
      instructorName: map['instructor_name'] ?? '',
      instructorBio: map['instructor_bio'] ?? '',
      instructorTitle: map['instructor_title'] ?? '',
      previewVideoId: map['preview_video_id'] ?? '',
      imageUrl: map['image_url'] ?? '',
      sections: List.from(map['sections'] ?? []),
      isEnrolled: map['is_enrolled'] ?? false,
    );
  }
}
