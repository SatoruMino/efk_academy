import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignOut implements Usecase<void, NoParam> {
  final AuthRepository authRepository;

  const SignOut(this.authRepository);

  @override
  Future<Either<Failure, void>> call(NoParam param) async {
    return await authRepository.signOut();
  }
}
