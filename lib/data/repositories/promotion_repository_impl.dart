import 'package:efk_academy/core/error/error.dart';
import 'package:efk_academy/data/datasources/promotion_remote_data_source.dart';
import 'package:efk_academy/domain/entities/promotion.dart';
import 'package:efk_academy/domain/repositories/promotion_repository.dart';
import 'package:fpdart/fpdart.dart';

class PromotionRepositoryImpl implements PromotionRepository {
  final PromotionRemoteDataSource promotionRemoteDataSource;

  const PromotionRepositoryImpl(this.promotionRemoteDataSource);

  @override
  Future<Either<Failure, List<Promotion>>> getPromotion() async {
    try {
      final promotions = await promotionRemoteDataSource.getPromotion();

      return right(promotions);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }
}
