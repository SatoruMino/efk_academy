import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

class SignIn implements Usecase<User, SignInWithPasswordParams> {
  final AuthRepository authRepository;

  const SignIn(this.authRepository);

  @override
  Future<Either<Failure, User>> call(SignInWithPasswordParams param) async {
    return await authRepository.signIn(param.email, param.password);
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
