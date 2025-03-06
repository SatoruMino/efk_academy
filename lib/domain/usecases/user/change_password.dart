import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/user.dart';
import 'package:efk_academy/domain/repositories/user_repository.dart';
import 'package:fpdart/fpdart.dart';

class ChangePassword implements Usecase<User, ChangePasswordParams> {
  final UserRepository userRepository;

  const ChangePassword(this.userRepository);

  @override
  Future<Either<Failure, User>> call(ChangePasswordParams param) async {
    return await userRepository.changePassword(
      param.currentPassword,
      param.newPassword,
    );
  }
}

class ChangePasswordParams {
  const ChangePasswordParams(
    this.currentPassword,
    this.newPassword,
  );

  final String currentPassword;
  final String newPassword;
}
