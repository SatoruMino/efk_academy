import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/promotion.dart';
import 'package:efk_academy/domain/repositories/promotion_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetPromotion implements Usecase<List<Promotion>, NoParam> {
  final PromotionRepository promotionRepository;

  const GetPromotion(this.promotionRepository);

  @override
  Future<Either<Failure, List<Promotion>>> call(NoParam param) async {
    return await promotionRepository.getPromotion();
  }
}
