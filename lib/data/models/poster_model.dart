import 'package:efk_academy/domain/entities/poster.dart';

class PosterModel extends Poster {
  PosterModel({
    required super.imageUrl,
  });

  static PosterModel fromJson(Map<String, dynamic> map) {
    return PosterModel(
      imageUrl: map['image_url'],
    );
  }
}
