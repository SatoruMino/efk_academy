import 'package:efk_academy/domain/entities/promotion.dart';

class PromotionModel extends Promotion {
  PromotionModel({required super.imageUrl});

  static PromotionModel fromJson(Map<String, dynamic> map) {
    return PromotionModel(
      imageUrl: map['image_url'] ?? '',
    );
  }
}
