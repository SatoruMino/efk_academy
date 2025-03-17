import 'package:efk_academy/domain/domain.dart';

class CourseModel extends Course {
  const CourseModel({
    required super.id,
    required super.name,
    required super.category,
    required super.price,
    required super.discount,
    required super.summary,
    required super.imageUrl,
    required super.description,
    required super.createdAt,
    required super.previewVideoId,
    required super.sections,
    required super.instructor,
  });

  factory CourseModel.fromJson(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      price: (map['price'] as num).toDouble(),
      discount: (map['discount'] as num).toDouble(),
      summary: map['summary'],
      imageUrl: map['image_url'] ?? '',
      description: map['description'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
      previewVideoId: map['preview_video_id'] ?? '',
      sections: List.from(map['sections'] as List<dynamic>)
          .map((sectionJson) => SectionModel.fromJson(sectionJson))
          .toList(),
      instructor: InstructorModel.fromJson(map['instructors']),
    );
  }
}

class InstructorModel extends Instructor {
  const InstructorModel({
    required super.id,
    required super.name,
    required super.title,
    required super.bio,
  });

  factory InstructorModel.fromJson(Map<String, dynamic> map) {
    return InstructorModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      title: map['title'] ?? '',
      bio: map['bio'] ?? '',
    );
  }
}

class SectionModel extends Section {
  const SectionModel({
    required super.id,
    required super.name,
    required super.lessons,
  });

  factory SectionModel.fromJson(Map<String, dynamic> map) {
    return SectionModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      lessons: List.from(map['lessons'] as List<dynamic>)
          .map((lessonJson) => LessonModel.fromJson(lessonJson))
          .toList(),
    );
  }
}

class LessonModel extends Lesson {
  const LessonModel({
    required super.id,
    required super.name,
    required super.videos,
  });

  factory LessonModel.fromJson(Map<String, dynamic> map) {
    return LessonModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      videos: List.from(map['videos'] as List<dynamic>)
          .map((videoJson) => VideoModel.fromJson(videoJson))
          .toList(),
    );
  }
}

class VideoModel extends Video {
  const VideoModel({
    required super.id,
    required super.name,
    required super.url,
  });

  factory VideoModel.fromJson(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      url: map['url'] ?? '',
    );
  }
}
