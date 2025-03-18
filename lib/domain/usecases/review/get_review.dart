import 'package:efk_academy/core/error/error.dart';
import 'package:efk_academy/core/usecase/usecase.dart';
import 'package:efk_academy/domain/entities/review.dart';
import 'package:efk_academy/domain/repositories/review_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetReview implements Usecase<List<Review>, String> {
  const GetReview(this.reviewRepository);

  final ReviewRepository reviewRepository;

  @override
  Future<Either<Failure, List<Review>>> call(String param) {
    return reviewRepository.getReview(param);
  }
}
