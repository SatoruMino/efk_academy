import 'package:easy_localization/easy_localization.dart';
import 'package:efk_academy/core/utils/math.dart';
import 'package:equatable/equatable.dart';

class Course extends Equatable {
  const Course({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.discount,
    required this.summary,
    required this.imageUrl,
    required this.createdAt,
    required this.description,
    required this.previewVideoId,
    required this.sections,
    required this.instructor,
  });

  final String id;
  final String name;
  final String category;
  final double price;
  final double discount;
  final String summary;
  final String imageUrl;
  final DateTime createdAt;
  final String description;
  final String previewVideoId;
  final Instructor instructor;
  final List<Section> sections;

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        discount,
        summary,
        description,
        createdAt,
        previewVideoId,
        imageUrl
      ];

  // .. get method
  int get getSectionCount => sections.length;
  String get getDate => DateFormat('dd/mm/yy').format(createdAt);
  double get getPrice => findPrice(price, discount);
}

class Instructor extends Equatable {
  const Instructor({
    required this.id,
    required this.name,
    required this.title,
    required this.bio,
  });

  final String id;
  final String name;
  final String title;
  final String bio;

  @override
  List<Object?> get props => [id, name, title, bio];
}

class Section extends Equatable {
  const Section({
    required this.id,
    required this.name,
    required this.lessons,
  });

  final String id;
  final String name;
  final List<Lesson> lessons;

  @override
  List<Object?> get props => [id, name, lessons];
}

class Lesson extends Equatable {
  const Lesson({
    required this.id,
    required this.name,
    required this.videos,
  });

  final String id;
  final String name;
  final List<Video> videos;

  @override
  List<Object?> get props => [id, name, videos];
}

class Video extends Equatable {
  const Video({
    required this.id,
    required this.name,
    required this.url,
  });

  final String id;
  final String name;
  final String url;

  @override
  List<Object?> get props => [id, name, url];
}
