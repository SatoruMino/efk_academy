import 'package:efk_academy/core/error/error.dart';
import 'package:efk_academy/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CartRepository {
  Future<Either<Failure, List<Cart>>> getCart();
  Future<Either<Failure, Cart>> addToCart(String courseId);
}
