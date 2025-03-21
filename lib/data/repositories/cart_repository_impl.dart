import 'package:efk_academy/core/error/error.dart';
import 'package:efk_academy/data/datasources/cart_remote_data_source.dart';
import 'package:efk_academy/data/models/cart_model.dart';
import 'package:efk_academy/domain/entities/cart.dart';
import 'package:efk_academy/domain/repositories/cart_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class CartRepositoryImpl implements CartRepository {
  const CartRepositoryImpl(this.cartRemoteDataSource);

  final CartRemoteDataSource cartRemoteDataSource;

  @override
  Future<Either<Failure, List<CartModel>>> getCart() async {
    try {
      final courses = await cartRemoteDataSource.getCart();

      return right(courses);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Cart>> addToCart(String courseId) async {
    try {
      final cartModel = CartModel(
        id: const Uuid().v1(),
        userId: '',
        courseId: courseId,
      );

      final cart = await cartRemoteDataSource.addToCart(cartModel);

      return right(cart);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Cart>> removeFromCart(String id) async {
    try {
      final cart = await cartRemoteDataSource.removeFromCart(id);

      return right(cart);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }
}
