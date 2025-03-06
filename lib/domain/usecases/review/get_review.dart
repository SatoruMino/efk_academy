import 'package:efk_academy/core/error/error.dart';
import 'package:efk_academy/core/usecase/usecase.dart';
import 'package:efk_academy/domain/entities/review.dart';
import 'package:efk_academy/domain/repositories/review_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetReview implements Usecase<List<Review>, String> {
  final ReviewRepository reviewRepository;

  const GetReview(this.reviewRepository);

  @override
  Future<Either<Failure, List<Review>>> call(String param) async {
    return await reviewRepository.getReview(param);
  }
}
