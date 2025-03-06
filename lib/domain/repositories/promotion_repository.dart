import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/promotion.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class PromotionRepository {
  Future<Either<Failure, List<Promotion>>> getPromotion();
}
