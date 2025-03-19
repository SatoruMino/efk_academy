import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

class GetCart implements Usecase<List<Cart>, NoParam> {
  const GetCart(this.cartRepository);

  final CartRepository cartRepository;

  @override
  Future<Either<Failure, List<Cart>>> call(NoParam param) async {
    return await cartRepository.getCart();
  }
}
