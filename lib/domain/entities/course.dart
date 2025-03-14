import 'package:equatable/equatable.dart';

class Course extends Equatable {
  const Course({
    required this.id,
    required this.name,
    required this.price,
    required this.discount,
    required this.summary,
    required this.description,
    required this.previewVideoId,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final double price;
  final double discount;
  final String summary;
  final String description;
  final String previewVideoId;
  final String imageUrl;

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        discount,
        summary,
        description,
        previewVideoId,
        imageUrl
      ];
}
