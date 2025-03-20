import 'package:efk_academy/core/error/error.dart';
import 'package:efk_academy/core/usecase/usecase.dart';
import 'package:efk_academy/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

class ChangePassword implements Usecase<void, ChangePasswordParams> {
  final AuthRepository authRepository;

  const ChangePassword(this.authRepository);

  @override
  Future<Either<Failure, void>> call(ChangePasswordParams param) async {
    return await authRepository.changePassword(
        param.password, param.newPassword);
  }
}

class ChangePasswordParams {
  const ChangePasswordParams(
    this.password,
    this.newPassword,
  );
  final String password;
  final String newPassword;
}
