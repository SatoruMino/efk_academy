import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

class SignUp implements Usecase<User, SignUpWithPasswordParams> {
  final AuthRepository authRepository;

  const SignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(SignUpWithPasswordParams param) async {
    return await authRepository.signUp(
      param.username,
      param.email,
      param.password,
    );
  }
}

class SignUpWithPasswordParams {
  const SignUpWithPasswordParams(this.username, this.email, this.password);

  final String username;
  final String email;
  final String password;
}
