import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/user.dart';
import 'package:efk_academy/domain/repositories/user_repository.dart';
import 'package:fpdart/fpdart.dart';

class ChangeUsername implements Usecase<User, String> {
  final UserRepository userRepository;

  const ChangeUsername(this.userRepository);

  @override
  Future<Either<Failure, User>> call(String param) async {
    return await userRepository.changeUsername(param);
  }
}
