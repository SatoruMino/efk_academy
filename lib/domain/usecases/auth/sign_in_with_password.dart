import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/user.dart';
import 'package:efk_academy/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignInWithPassword implements Usecase<User, SignInWithPasswordParams> {
  final AuthRepository authRepository;

  const SignInWithPassword(this.authRepository);

  @override
  Future<Either<Failure, User>> call(SignInWithPasswordParams param) async {
    return await authRepository.signInWithPassword(param.email, param.password);
  }
}

class SignInWithPasswordParams {
  const SignInWithPasswordParams(
    this.email,
    this.password,
  );

  final String email;
  final String password;
}
