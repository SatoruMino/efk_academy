import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/user.dart';
import 'package:efk_academy/domain/repositories/user_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetUser implements Usecase<User?, NoParam> {
  final UserRepository userRepository;

  const GetUser(this.userRepository);

  @override
  Future<Either<Failure, User?>> call(NoParam param) async {
    return await userRepository.getUser();
  }
}
