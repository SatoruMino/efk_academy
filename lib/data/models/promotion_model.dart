import 'package:efk_academy/domain/entities/promotion.dart';

class PromotionModel extends Promotion {
  const PromotionModel({required super.imageUrl});

  factory PromotionModel.fromJson(Map<String, dynamic> map) {
    return PromotionModel(
      imageUrl: map['image_url'] ?? '',
    );
  }
}
