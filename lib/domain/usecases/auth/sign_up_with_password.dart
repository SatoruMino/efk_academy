import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/user.dart';
import 'package:efk_academy/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignUpWithPassword implements Usecase<User, SignUpWithPasswordParams> {
  final AuthRepository authRepository;

  const SignUpWithPassword(this.authRepository);

  @override
  Future<Either<Failure, User>> call(SignUpWithPasswordParams param) async {
    return await authRepository.signUpWithPassword(
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
