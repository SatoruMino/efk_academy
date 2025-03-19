import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

class AddToCart implements Usecase<Cart, String> {
  const AddToCart(this.cartRepository);

  final CartRepository cartRepository;

  @override
  Future<Either<Failure, Cart>> call(String param) async {
    return await cartRepository.addToCart(param);
  }
}
