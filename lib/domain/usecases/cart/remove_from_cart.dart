import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

class RemoveFromCart implements Usecase<Cart, String> {
  const RemoveFromCart(this.cartRepository);

  final CartRepository cartRepository;

  @override
  Future<Either<Failure, Cart>> call(String param) async {
    return await cartRepository.removeFromCart(param);
  }
}
